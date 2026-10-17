
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const IraqiBooksApp());
}

const Color primaryColor = Color(0xFF1565C0);

const String islamicBookUrl =
    'https://drive.google.com/uc?export=download&id=1idf1IS_S_XcSXCoDFb59tpaH41hyYEzu';

// ==================== الدوال المساعدة ====================

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

Future<void> copyBookLink(
  BuildContext context,
  String url,
) async {
  try {
    await Clipboard.setData(ClipboardData(text: url));

    if (!context.mounted) return;
    showMessage(context, 'تم نسخ رابط الكتاب بنجاح');
  } catch (_) {
    if (!context.mounted) return;
    showMessage(context, 'تعذّر نسخ الرابط');
  }
}

Future<void> openBookLink(
  BuildContext context,
  String url,
) async {
  final uri = Uri.tryParse(url);

  if (uri == null ||
      (uri.scheme != 'https' && uri.scheme != 'http')) {
    showMessage(context, 'رابط الكتاب غير صالح');
    return;
  }

  try {
    final opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!context.mounted) return;

    if (!opened) {
      showMessage(context, 'تعذّر فتح الرابط');
    }
  } catch (_) {
    if (!context.mounted) return;
    showMessage(context, 'حدث خطأ أثناء فتح الكتاب');
  }
}

// ==================== نماذج البيانات ====================

class BookSubject {
  final String name;
  final String url;

  const BookSubject(this.name, {this.url = ''});

  bool get available => url.isNotEmpty;
}

class SchoolGrade {
  final String name;
  final List<BookSubject> subjects;

  const SchoolGrade(this.name, this.subjects);
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

List<BookSubject> createSubjects(
  List<String> names, {
  bool firstGrade = false,
}) {
  return names.map((name) {
    if (firstGrade &&
        name == 'القرآن الكريم والتربية الإسلامية') {
      // تم إصلاح الخطأ: حذف const هنا
      return BookSubject(
        name,
        url: islamicBookUrl,
      );
    }

    return BookSubject(name);
  }).toList();
}

// ==================== المواد الدراسية ====================

const List<String> primarySubjects = [
  'القرآن الكريم والتربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنجليزية',
  'الرياضيات',
  'العلوم',
  'الاجتماعيات',
];

const List<String> middleSubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنجليزية',
  'الرياضيات',
  'العلوم',
  'الاجتماعيات',
  'الحاسوب',
];

const List<String> preparatorySubjects = [
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
    grades: List.generate(6, (index) {
      const names = [
        'الصف الأول الابتدائي',
        'الصف الثاني الابتدائي',
        'الصف الثالث الابتدائي',
        'الصف الرابع الابتدائي',
        'الصف الخامس الابتدائي',
        'الصف السادس الابتدائي',
      ];

      return SchoolGrade(
        names[index],
        createSubjects(
          primarySubjects,
          firstGrade: index == 0,
        ),
      );
    }),
  ),
  SchoolStage(
    name: 'المرحلة المتوسطة',
    description: 'من الأول إلى الثالث المتوسط',
    icon: Icons.school,
    grades: List.generate(3, (index) {
      const names = [
        'الأول المتوسط',
        'الثاني المتوسط',
        'الثالث المتوسط',
      ];

      return SchoolGrade(
        names[index],
        createSubjects(middleSubjects),
      );
    }),
  ),
  SchoolStage(
    name: 'المرحلة الإعدادية',
    description: 'من الرابع إلى السادس الإعدادي',
    icon: Icons.cast_for_education,
    grades: List.generate(3, (index) {
      const names = [
        'الرابع الإعدادي',
        'الخامس الإعدادي',
        'السادس الإعدادي',
      ];

      return SchoolGrade(
        names[index],
        createSubjects(preparatorySubjects),
      );
    }),
  ),
];

// ==================== التطبيق الرئيسي ====================

class IraqiBooksApp extends StatefulWidget {
  const IraqiBooksApp({super.key});

  @override
  State<IraqiBooksApp> createState() => _IraqiBooksAppState();
}

class _IraqiBooksAppState extends State<IraqiBooksApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مكتبة المناهج العراقية',
      debugShowCheckedModeBanner: false,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: HomeScreen(
        darkMode: darkMode,
        onToggleTheme: () {
          setState(() {
            darkMode = !darkMode;
          });
        },
      ),
    );
  }
}

// ==================== الصفحة الرئيسية ====================

class HomeScreen extends StatefulWidget {
  final bool darkMode;
  final VoidCallback onToggleTheme;

  const HomeScreen({
    super.key,
    required this.darkMode,
    required this.onToggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final Set<String> favorites = {};

  String query = '';

  void toggleFavorite(String key) {
    setState(() {
      if (favorites.contains(key)) {
        favorites.remove(key);
      } else {
        favorites.add(key);
      }
    });
  }

  void openGrades(SchoolStage stage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GradesScreen(
          stage: stage,
          favorites: favorites,
          onToggle: toggleFavorite,
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  void openSubjects(SchoolGrade grade) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SubjectsScreen(
          grade: grade,
          favorites: favorites,
          onToggle: toggleFavorite,
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  void openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FavoritesScreen(
          favorites: favorites,
          onToggle: toggleFavorite,
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();

    final results = <Map<String, dynamic>>[];

    if (normalizedQuery.isNotEmpty) {
      for (final stage in schoolStages) {
        for (final grade in stage.grades) {
          final matches =
              stage.name.toLowerCase().contains(normalizedQuery) ||
              grade.name.toLowerCase().contains(normalizedQuery) ||
              grade.subjects.any(
                (subject) => subject.name
                    .toLowerCase()
                    .contains(normalizedQuery),
              );

          if (matches) {
            results.add({
              'stage': stage,
              'grade': grade,
            });
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مكتبة المناهج العراقية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'المفضلة',
            onPressed: openFavorites,
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            tooltip: widget.darkMode
                ? 'الوضع الفاتح'
                : 'الوضع الليلي',
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.darkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1565C0),
                  Color(0xFF00897B),
                ],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.auto_stories,
                  size: 42,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  'كتبك الدراسية في مكان واحد',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'اكتشف المناهج العراقية وابحث عن كتابك بسهولة.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'ابحث عن مرحلة أو صف أو مادة...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'مسح البحث',
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          query = '';
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            normalizedQuery.isEmpty
                ? 'المراحل الدراسية'
                : 'نتائج البحث',
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (normalizedQuery.isEmpty) ...[
            ...schoolStages.map((stage) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: CircleAvatar(
                      backgroundColor: primaryColor.withAlpha(25),
                      child: Icon(
                        stage.icon,
                        color: primaryColor,
                      ),
                    ),
                    title: Text(
                      stage.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(stage.description),
                    trailing: const Icon(Icons.chevron_left),
                    onTap: () => openGrades(stage),
                  ),
                ),
              );
            }),
          ] else ...[
            Text('عدد النتائج: ${results.length}'),
            const SizedBox(height: 10),
            if (results.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text('لا توجد نتائج مطابقة للبحث.'),
                ),
              ),
            ...results.map((result) {
              final stage = result['stage'] as SchoolStage;
              final grade = result['grade'] as SchoolGrade;

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Icon(
                    stage.icon,
                    color: primaryColor,
                  ),
                  title: Text(grade.name),
                  subtitle: Text(stage.name),
                  trailing: const Icon(Icons.chevron_left),
                  onTap: () => openSubjects(grade),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

// ==================== صفحة الصفوف ====================

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
      body: ListView.separated(
        padding: const EdgeInsets.all(14),
        itemCount: stage.grades.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final grade = stage.grades[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.class_,
                color: primaryColor,
              ),
              title: Text(grade.name),
              subtitle: Text(
                '${grade.subjects.length} مواد دراسية',
              ),
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

// ==================== صفحة المواد ====================

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

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = query.trim().toLowerCase();

    final subjects = widget.grade.subjects.where((subject) {
      return subject.name.toLowerCase().contains(normalizedQuery);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.grade.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'ابحث عن مادة...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Expanded(
            child: subjects.isEmpty
                ? const Center(
                    child: Text('لا توجد مواد مطابقة.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      final key =
                          '${widget.grade.name}_${subject.name}';
                      final favorite =
                          widget.favorites.contains(key);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.menu_book,
                                    color: primaryColor,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      subject.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: favorite
                                        ? 'حذف من المفضلة'
                                        : 'إضافة إلى المفضلة',
                                    onPressed: () {
                                      widget.onToggle(key);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      favorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favorite
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                subject.available
                                    ? 'الكتاب متاح'
                                    : 'لم تتم إضافة رابط الكتاب بعد',
                                style: TextStyle(
                                  color: subject.available
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  onPressed: subject.available
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  BookPreviewScreen(
                                                subject: subject,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.menu_book),
                                  label: const Text('فتح الكتاب'),
                                ),
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

// ==================== شاشة الكتاب ====================

class BookPreviewScreen extends StatelessWidget {
  final BookSubject subject;

  const BookPreviewScreen({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.picture_as_pdf,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 18),
              Text(
                subject.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'يمكنك فتح الكتاب من خلال المتصفح. '
                'تأكد من أن ملف Google Drive متاح لمن يملك الرابط.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () async {
                    await openBookLink(context, subject.url);
                  },
                  icon: const Icon(Icons.open_in_browser),
                  label: const Text('فتح الكتاب'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await copyBookLink(context, subject.url);
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('نسخ الرابط'),
                ),
              ),
              const SizedBox(height: 18),
              SelectableText(
                subject.url,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== شاشة المفضلة ====================

class FavoritesScreen extends StatefulWidget {
  final Set<String> favorites;
  final void Function(String) onToggle;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onToggle,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final items = <MapEntry<String, BookSubject>>[];

    for (final stage in schoolStages) {
      for (final grade in stage.grades) {
        for (final subject in grade.subjects) {
          final key = '${grade.name}_${subject.name}';

          if (widget.favorites.contains(key)) {
            items.add(MapEntry(grade.name, subject));
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: items.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 65,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text('لم تضف أي مادة إلى المفضلة بعد.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final key =
                    '${item.key}_${item.value.name}';

                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.menu_book,
                      color: primaryColor,
                    ),
                    title: Text(item.value.name),
                    subtitle: Text(item.key),
                    trailing: IconButton(
                      tooltip: 'حذف من المفضلة',
                      onPressed: () {
                        widget.onToggle(key);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                    onTap: item.value.available
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookPreviewScreen(
                                  subject: item.value,
                                ),
                              ),
                            );
                          }
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
