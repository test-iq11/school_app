
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

void main() {
  runApp(const IraqiBooksApp());
}

class IraqiBooksApp extends StatelessWidget {
  const IraqiBooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مكتبة المناهج العراقية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
        ),
      ),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
      home: const HomeScreen(),
    );
  }
}

class SchoolStage {
  final String name;
  final String description;
  final IconData icon;
  final List<SchoolGrade> grades;

  const SchoolStage({
    required this.name,
    required this.description,
    required this.icon,
    required this.grades,
  });
}

class SchoolGrade {
  final String name;
  final List<BookSubject> subjects;

  const SchoolGrade({
    required this.name,
    required this.subjects,
  });
}

class BookSubject {
  final String name;
  final String pdfUrl;

  const BookSubject({
    required this.name,
    this.pdfUrl = '',
  });
}

// ضع رابط PDF الحقيقي لكل كتاب في pdfUrl.
// اتركه فارغاً إلى أن يتوفر رابط الكتاب.
List<BookSubject> makeSubjects(List<String> names) {
  return names.map((name) => BookSubject(name: name)).toList();
}

final List<String> primarySubjects = [
  'القرآن الكريم والتربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنجليزية',
  'الرياضيات',
  'العلوم',
  'الاجتماعيات',
];

final List<String> middleSubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنجليزية',
  'الرياضيات',
  'العلوم',
  'الاجتماعيات',
  'الحاسوب',
];

final List<String> preparatorySubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنجليزية',
  'الرياضيات',
  'الفيزياء',
  'الكيمياء',
  'الأحياء',
];

final List<SchoolStage> schoolStages = [
  SchoolStage(
    name: 'المرحلة الابتدائية',
    description: 'من الصف الأول إلى الصف السادس',
    icon: Icons.menu_book,
    grades: [
      SchoolGrade(name: 'الصف الأول الابتدائي',
          subjects: makeSubjects(primarySubjects)),
      SchoolGrade(name: 'الصف الثاني الابتدائي',
          subjects: makeSubjects(primarySubjects)),
      SchoolGrade(name: 'الصف الثالث الابتدائي',
          subjects: makeSubjects(primarySubjects)),
      SchoolGrade(name: 'الصف الرابع الابتدائي',
          subjects: makeSubjects(primarySubjects)),
      SchoolGrade(name: 'الصف الخامس الابتدائي',
          subjects: makeSubjects(primarySubjects)),
      SchoolGrade(name: 'الصف السادس الابتدائي',
          subjects: makeSubjects(primarySubjects)),
    ],
  ),
  SchoolStage(
    name: 'المرحلة المتوسطة',
    description: 'من الصف الأول إلى الصف الثالث المتوسط',
    icon: Icons.school,
    grades: [
      SchoolGrade(name: 'الأول المتوسط',
          subjects: makeSubjects(middleSubjects)),
      SchoolGrade(name: 'الثاني المتوسط',
          subjects: makeSubjects(middleSubjects)),
      SchoolGrade(name: 'الثالث المتوسط',
          subjects: makeSubjects(middleSubjects)),
    ],
  ),
  SchoolStage(
    name: 'المرحلة الإعدادية',
    description: 'الصفوف الرابع والخامس والسادس الإعدادي',
    icon: Icons.cast_for_education,
    grades: [
      SchoolGrade(name: 'الرابع الإعدادي',
          subjects: makeSubjects(preparatorySubjects)),
      SchoolGrade(name: 'الخامس الإعدادي',
          subjects: makeSubjects(preparatorySubjects)),
      SchoolGrade(name: 'السادس الإعدادي',
          subjects: makeSubjects(preparatorySubjects)),
    ],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> favorites = {};

  void toggleFavorite(String key) {
    setState(() {
      if (favorites.contains(key)) {
        favorites.remove(key);
      } else {
        favorites.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مكتبة المناهج العراقية'),
        actions: [
          IconButton(
            tooltip: 'المفضلة',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favorites: favorites,
                    onToggle: toggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'كتبك الدراسية في مكان واحد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'اختر المرحلة ثم الصف والمادة لقراءة الكتاب أو تنزيله.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'المراحل الدراسية',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...schoolStages.map((stage) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: CircleAvatar(
                  radius: 27,
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Icon(stage.icon,
                      color: const Color(0xFF1565C0), size: 30),
                ),
                title: Text(
                  stage.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(stage.description),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GradesScreen(
                        stage: stage,
                        favorites: favorites,
                        onToggle: toggleFavorite,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class GradesScreen extends StatelessWidget {
  final SchoolStage stage;
  final Set<String> favorites;
  final void Function(String) onToggle;

  const GradesScreen({
    super.key,
    required this.stage,
    required this.favorites,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stage.name)),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: stage.grades.length,
        itemBuilder: (context, index) {
          final grade = stage.grades[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.class_, color: Color(0xFF1565C0)),
              title: Text(grade.name),
              trailing: const Icon(Icons.chevron_left),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubjectsScreen(
                      grade: grade,
                      favorites: favorites,
                      onToggle: onToggle,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SubjectsScreen extends StatefulWidget {
  final SchoolGrade grade;
  final Set<String> favorites;
  final void Function(String) onToggle;

  const SubjectsScreen({
    super.key,
    required this.grade,
    required this.favorites,
    required this.onToggle,
  });

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  String query = '';

  String keyFor(BookSubject subject) =>
      '${widget.grade.name}_${subject.name}';

  @override
  Widget build(BuildContext context) {
    final subjects = widget.grade.subjects.where((subject) {
      return subject.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.grade.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن مادة...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),
          Expanded(
            child: subjects.isEmpty
                ? const Center(child: Text('لا توجد نتائج للبحث'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      final key = keyFor(subject);
                      final isFavorite = widget.favorites.contains(key);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.menu_book,
                                      color: Color(0xFF1565C0), size: 30),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      subject.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'إضافة إلى المفضلة',
                                    onPressed: () {
                                      widget.onToggle(key);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: FilledButton.icon(
                                      onPressed: () async {
                                        if (subject.pdfUrl.trim().isEmpty) {
                                          showMessage(
                                            context,
                                            'أضف رابط PDF الحقيقي لهذا الكتاب أولاً.',
                                          );
                                          return;
                                        }
                                        await downloadBook(
                                          context,
                                          subject,
                                          widget.grade.name,
                                        );
                                      },
                                      icon: const Icon(Icons.download),
                                      label: const Text('تحميل الكتاب'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () async {
                                        if (subject.pdfUrl.trim().isEmpty) {
                                          showMessage(
                                            context,
                                            'أضف رابط PDF الحقيقي لهذا الكتاب أولاً.',
                                          );
                                          return;
                                        }
                                        await readBook(
                                          context,
                                          subject,
                                          widget.grade.name,
                                        );
                                      },
                                      icon: const Icon(Icons.menu_book),
                                      label: const Text('قراءة الكتاب'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final Set<String> favorites;
  final void Function(String) onToggle;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final entries = <MapEntry<String, BookSubject>>[];

    for (final stage in schoolStages) {
      for (final grade in stage.grades) {
        for (final subject in grade.subjects) {
          final key = '${grade.name}_${subject.name}';
          if (favorites.contains(key)) {
            entries.add(MapEntry(key, subject));
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: entries.isEmpty
          ? const Center(child: Text('لم تضف أي مادة إلى المفضلة بعد.'))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(entry.value.name),
                  subtitle: Text(entry.key.split('_').first),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => onToggle(entry.key),
                  ),
                );
              },
            ),
    );
  }
}

Future<Directory> bookDirectory() async {
  final root = await getApplicationDocumentsDirectory();
  final directory = Directory('${root.path}/books');

  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }

  return directory;
}

String safeFileName(String value) {
  return value.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
}

Future<File> downloadPdfFile(
  BookSubject subject,
  String gradeName,
) async {
  final directory = await bookDirectory();
  final fileName = '${safeFileName(gradeName)}_'
      '${safeFileName(subject.name)}.pdf';
  final file = File('${directory.path}/$fileName');

  await Dio().download(
    subject.pdfUrl,
    file.path,
    options: Options(
      followRedirects: true,
      receiveTimeout: const Duration(minutes: 3),
      sendTimeout: const Duration(minutes: 1),
      headers: {'Accept': 'application/pdf,*/*'},
    ),
    deleteOnError: true,
  );

  final handle = await file.open();
  final header = await handle.read(5);
  await handle.close();

  if (header.length < 5 ||
      String.fromCharCodes(header) != '%PDF-') {
    await file.delete();
    throw Exception(
      'الرابط لم يرجع ملف PDF مباشراً. استخدم رابط تنزيل PDF صالحاً.',
    );
  }

  return file;
}

Future<void> downloadBook(
  BuildContext context,
  BookSubject subject,
  String gradeName,
) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 18),
          Expanded(child: Text('جارٍ تحميل الكتاب...')),
        ],
      ),
    ),
  );

  try {
    final file = await downloadPdfFile(subject, gradeName);

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('اكتمل التحميل'),
        content: Text(
          'تم حفظ الكتاب داخل التطبيق.\n\nالمسار:\n${file.path}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('حسناً'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PdfReaderScreen(
                    file: file,
                    title: subject.name,
                  ),
                ),
              );
            },
            child: const Text('قراءة الكتاب'),
          ),
        ],
      ),
    );
  } catch (error) {
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    showMessage(context, 'تعذر تحميل الكتاب: $error');
  }
}

Future<void> readBook(
  BuildContext context,
  BookSubject subject,
  String gradeName,
) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 18),
          Expanded(child: Text('جارٍ تجهيز الكتاب للقراءة...')),
        ],
      ),
    ),
  );

  try {
    final file = await downloadPdfFile(subject, gradeName);

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PdfReaderScreen(
          file: file,
          title: subject.name,
        ),
      ),
    );
  } catch (error) {
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    showMessage(context, 'تعذر فتح الكتاب: $error');
  }
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

class PdfReaderScreen extends StatefulWidget {
  final File file;
  final String title;

  const PdfReaderScreen({
    super.key,
    required this.file,
    required this.title,
  });

  @override
  State<PdfReaderScreen> createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  late final PdfControllerPinch controller;
  int currentPage = 1;
  int pageCount = 0;

  @override
  void initState() {
    super.initState();
    controller = PdfControllerPinch(
      document: PdfDocument.openFile(widget.file.path),
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                pageCount == 0
                    ? '$currentPage'
                    : '$currentPage / $pageCount',
              ),
            ),
          ),
        ],
      ),
      body: PdfViewPinch(
        controller: controller,
        onDocumentLoaded: (document) {
          if (!mounted) return;
          setState(() => pageCount = document.pagesCount);
        },
        onPageChanged: (page) {
          if (!mounted) return;
          setState(() => currentPage = page);
        },
        onDocumentError: (error) {
          if (!mounted) return;
          showMessage(context, 'تعذر عرض ملف PDF: $error');
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'الصفحة السابقة',
                onPressed: () {
                  if (currentPage > 1) {
                    controller.previousPage(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 250),
                    );
                  }
                },
                icon: const Icon(Icons.chevron_right),
              ),
              Text('صفحة $currentPage'),
              IconButton(
                tooltip: 'الصفحة التالية',
                onPressed: () {
                  if (pageCount == 0 || currentPage < pageCount) {
                    controller.nextPage(
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 250),
                    );
                  }
                },
                icon: const Icon(Icons.chevron_left),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
