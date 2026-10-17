
import 'offline_book_model.dart';

Future<OfflineBookInfo?> saveBookOffline({
  required String key,
  required String title,
  required String grade,
  required String subject,
  required String url,
}) async => null;

Future<List<OfflineBookInfo>> loadOfflineBooks() async => <OfflineBookInfo>[];
Future<bool> hasOfflineBook(String key) async => false;
Future<bool> openOfflineBook(String key) async => false;
Future<bool> deleteOfflineBook(String key) async => false;

