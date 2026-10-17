
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import 'offline_book_model.dart';

Future<Directory> _offlineDirectory() async {
  final documents = await getApplicationDocumentsDirectory();
  final dir = Directory('${documents.path}${Platform.pathSeparator}offline_books');
  if (!await dir.exists()) await dir.create(recursive: true);
  return dir;
}

String _fileToken(String key) => base64Url.encode(utf8.encode(key)).replaceAll('=', '');

String _directDownloadUrl(String url) {
  final id = RegExp(r'/d/([^/?]+)').firstMatch(url)?.group(1);
  if (id == null) return url;
  return 'https://drive.google.com/uc?export=download&id=$id';
}

Future<OfflineBookInfo?> saveBookOffline({
  required String key,
  required String title,
  required String grade,
  required String subject,
  required String url,
}) async {
  if (url.trim().isEmpty) throw ArgumentError('رابط الكتاب غير متوفر.');

  final directory = await _offlineDirectory();
  final token = _fileToken(key);
  final pdf = File('${directory.path}${Platform.pathSeparator}$token.pdf');
  final metadata = File('${directory.path}${Platform.pathSeparator}$token.meta.json');

  final response = await http
      .get(Uri.parse(_directDownloadUrl(url)), headers: const {'Accept': 'application/pdf,*/*'})
      .timeout(const Duration(seconds: 90));
  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw HttpException('تعذر تنزيل الملف (HTTP ${response.statusCode}).');
  }
  final bytes = response.bodyBytes;
  final isPdf = bytes.length >= 4 && bytes[0] == 0x25 && bytes[1] == 0x50 && bytes[2] == 0x44 && bytes[3] == 0x46;
  if (!isPdf) {
    throw const FormatException('لم يُرجع Google Drive ملف PDF مباشراً. افتح الرابط وتأكد من إتاحة الملف للجميع، ثم جرّب مجدداً.');
  }

  await pdf.writeAsBytes(bytes, flush: true);
  final info = OfflineBookInfo(
    key: key,
    title: title,
    grade: grade,
    subject: subject,
    url: url,
    path: pdf.path,
  );
  await metadata.writeAsString(jsonEncode(info.toJson()), flush: true);
  return info;
}

Future<List<OfflineBookInfo>> loadOfflineBooks() async {
  final directory = await _offlineDirectory();
  final found = <OfflineBookInfo>[];
  await for (final entity in directory.list()) {
    if (entity is! File || !entity.path.endsWith('.meta.json')) continue;
    try {
      final decoded = jsonDecode(await entity.readAsString());
      final info = OfflineBookInfo.fromJson(Map<String, dynamic>.from(decoded as Map));
      if (info.path.isNotEmpty && await File(info.path).exists()) found.add(info);
    } catch (_) {
      // Ignore corrupt metadata and continue loading other offline books.
    }
  }
  found.sort((a, b) => a.title.compareTo(b.title));
  return found;
}

Future<bool> hasOfflineBook(String key) async {
  final directory = await _offlineDirectory();
  return File('${directory.path}${Platform.pathSeparator}${_fileToken(key)}.pdf').exists();
}

Future<bool> openOfflineBook(String key) async {
  final directory = await _offlineDirectory();
  final pdf = File('${directory.path}${Platform.pathSeparator}${_fileToken(key)}.pdf');
  if (!await pdf.exists()) return false;
  await OpenFilex.open(pdf.path);
  return true;
}

Future<bool> deleteOfflineBook(String key) async {
  final directory = await _offlineDirectory();
  final token = _fileToken(key);
  final pdf = File('${directory.path}${Platform.pathSeparator}$token.pdf');
  final metadata = File('${directory.path}${Platform.pathSeparator}$token.meta.json');
  var deleted = false;
  if (await pdf.exists()) {
    await pdf.delete();
    deleted = true;
  }
  if (await metadata.exists()) await metadata.delete();
  return deleted;
}

