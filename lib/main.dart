
import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() => runApp(const IraqiLibraryApp());

const navy = Color(0xFF142D4E);
const blue = Color(0xFF2864E8);
const teal = Color(0xFF0C9B83);
const purple = Color(0xFF8655C8);
const canvas = Color(0xFFF4F7FC);

const islamicBookUrl =
    'https://drive.google.com/file/d/1idf1IS_S_XcSXCoDFb59tpaH41hyYEzu/preview';

const grades = [
  'الأول الابتدائي',
  'الثاني الابتدائي',
  'الثالث الابتدائي',
  'الرابع الابتدائي',
  'الخامس الابتدائي',
  'السادس الابتدائي',
  'الأول المتوسط',
  'الثاني المتوسط',
  'الثالث المتوسط',
  'الرابع العلمي',
  'الخامس العلمي',
  'السادس العلمي',
  'الرابع الأدبي',
  'الخامس الأدبي',
  'السادس الأدبي',
];

List<String> gradeSubjectsFor(String grade) {
  if (grade.contains('الابتدائي')) {
    final number = grades.indexOf(grade) + 1;

    final result = <String>[
      'الإسلامية',
      'اللغة العربية',
      'اللغة الإنكليزية',
      'الرياضيات',
      'العلوم',
    ];

    if (number >= 4) {
      result.add('الاجتماعيات');
    }

    result.addAll([
      'التربية الفنية',
      'التربية الرياضية',
      'الحاسوب',
    ]);

    return result;
  }

  if (grade.contains('المتوسط')) {
    return [
      'الإسلامية',
      'اللغة العربية',
      'اللغة الإنكليزية',
      'الرياضيات',
      'العلوم',
      'الاجتماعيات',
      'الحاسوب',
      'التربية الفنية',
      'التربية الرياضية',
    ];
  }

  if (grade.contains('العلمي')) {
    return [
      'الإسلامية',
      'اللغة العربية',
      'اللغة الإنكليزية',
      'الرياضيات',
      'الفيزياء',
      'الكيمياء',
      'الأحياء',
      'الحاسوب',
    ];
  }

  return [
    'الإسلامية',
    'اللغة العربية',
    'اللغة الإنكليزية',
    'الرياضيات',
    'التاريخ',
    'الجغرافية',
    'الاقتصاد',
    'الحاسوب',
  ];
}

Color gradeColor(String grade) {
  if (grade.contains('الابتدائي')) return teal;
  if (grade.contains('المتوسط')) return blue;
  return purple;
}

String gradeStage(String grade) {
  if (grade.contains('الابتدائي')) return 'المرحلة الابتدائية';
  if (grade.contains('المتوسط')) return 'المرحلة المتوسطة';
  return 'المرحلة الإعدادية';
}

IconData gradeIcon(String grade) {
  if (grade.contains('الابتدائي')) return Icons.child_care_rounded;
  if (grade.contains('المتوسط')) return Icons.school_rounded;
  if (grade.contains('العلمي')) return Icons.science_rounded;
  if (grade.contains('الأدبي')) return Icons.menu_book_rounded;
  return Icons.school_rounded;
}

IconData subjectIcon(String subject) {
  switch (subject) {
    case 'الرياضيات':
      return Icons.calculate_rounded;
    case 'العلوم':
      return Icons.science_rounded;
    case 'اللغة العربية':
      return Icons.menu_book_rounded;
    case 'اللغة الإنكليزية':
      return Icons.translate_rounded;
    case 'الاجتماعيات':
    case 'الجغرافية':
      return Icons.public_rounded;
    case 'التاريخ':
      return Icons.history_edu_rounded;
    case 'الإسلامية':
      return Icons.mosque_rounded;
    case 'الفيزياء':
      return Icons.bolt_rounded;
    case 'الكيمياء':
      return Icons.biotech_rounded;
    case 'الأحياء':
      return Icons.spa_rounded;
    case 'الحاسوب':
      return Icons.computer_rounded;
    case 'الاقتصاد':
      return Icons.account_balance_rounded;
    case 'التربية الفنية':
      return Icons.palette_rounded;
    case 'التربية الرياضية':
      return Icons.sports_soccer_rounded;
    default:
      return Icons.auto_stories_rounded;
  }
}

Color subjectColor(String subject) {
  switch (subject) {
    case 'الرياضيات':
      return blue;
    case 'العلوم':
    case 'الكيمياء':
      return teal;
    case 'اللغة العربية':
      return purple;
    case 'اللغة الإنكليزية':
      return const Color(0xFFEC9142);
    case 'الاجتماعيات':
    case 'الجغرافية':
      return const Color(0xFF478C76);
    case 'الإسلامية':
      return const Color(0xFFB88A37);
    case 'الفيزياء':
      return const Color(0xFF5078CC);
    case 'الأحياء':
      return const Color(0xFF65A45B);
    case 'التاريخ':
      return const Color(0xFFAD6550);
    case 'الاقتصاد':
      return const Color(0xFF398A91);
    case 'الحاسوب':
      return const Color(0xFF5D6DAB);
    case 'التربية الفنية':
      return const Color(0xFFDB719A);
    case 'التربية الرياضية':
      return const Color(0xFF549D62);
    default:
      return blue;
  }
}

class SchoolBook {
  final String title;
  final String subject;
  final String grade;
  final String url;

  const SchoolBook({
    required this.title,
    required this.subject,
    required this.grade,
    required this.url,
  });

  String get key => '$title|$grade';
}

List<SchoolBook> makeBooks() {
  final books = <SchoolBook>[];

  for (final grade in grades) {
    for (final subject in gradeSubjectsFor(grade)) {
      books.add(
        SchoolBook(
          title: 'كتاب $subject',
          subject: subject,
          grade: grade,
          url: subject == 'الإسلامية' &&
                  grade == 'الأول الابتدائي'
              ? islamicBookUrl
              : '',
        ),
      );
    }
  }

  return books;
}

class IraqiLibraryApp extends StatefulWidget {
  const IraqiLibraryApp({super.key});

  @override
  State<IraqiLibraryApp> createState() => _IraqiLibraryAppState();
}

class _IraqiLibraryAppState extends State<IraqiLibraryApp> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مكتبة المناهج العراقية',
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas,
          foregroundColor: navy,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Color(0xFFE8EDF5)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
      home: LibraryHome(
        dark: dark,
        onDarkChanged: (value) => setState(() => dark = value),
      ),
    );
  }
}

class LibraryHome extends StatefulWidget {
  final bool dark;
  final ValueChanged<bool> onDarkChanged;

  const LibraryHome({
    super.key,
    required this.dark,
    required this.onDarkChanged,
  });

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  final books = makeBooks();
  final favorites = <String>{};
  final notes = <String>[];
  final noteController = TextEditingController();
  final searchController = TextEditingController();

  String selectedGrade = grades.first;
  String search = '';
  int page = 0;

  List<SchoolBook> get visibleBooks {
    final source = page == 1
        ? books.where((book) => favorites.contains(book.key))
        : books.where((book) => book.grade == selectedGrade);

    return source.where((book) {
      final query = search.trim().toLowerCase();
      return query.isEmpty ||
          book.title.toLowerCase().contains(query) ||
          book.subject.toLowerCase().contains(query) ||
          book.grade.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    noteController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void changePage(int value) {
    FocusScope.of(context).unfocus();
    setState(() => page = value);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72,
          title: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [blue, Color(0xFF6B8FF5)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 11),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مكتبتي',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'المناهج الدراسية العراقية',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'الوضع الليلي',
              onPressed: () => widget.onDarkChanged(!widget.dark),
              icon: Icon(
                widget.dark
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 760;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: IndexedStack(
                    index: page,
                    children: [
                      buildLibrary(wide),
                      buildFavorites(wide),
                      buildExams(),
                      buildNotes(),
                      buildSettings(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: page,
          onDestinationSelected: changePage,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border_rounded),
              selectedIcon: Icon(Icons.favorite_rounded),
              label: 'المفضلة',
            ),
            NavigationDestination(
              icon: Icon(Icons.quiz_outlined),
              selectedIcon: Icon(Icons.quiz_rounded),
              label: 'الاختبارات',
            ),
            NavigationDestination(
              icon: Icon(Icons.sticky_note_2_outlined),
              selectedIcon: Icon(Icons.sticky_note_2_rounded),
              label: 'ملاحظاتي',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings_rounded),
              label: 'الإعدادات',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLibrary(bool wide) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      children: [
        heroBanner(),
        const SizedBox(height: 24),
        const SectionHeading(
          title: 'اختر صفك الدراسي',
          subtitle: 'قائمة ملوّنة لتسهيل الوصول إلى صفك',
        ),
        const SizedBox(height: 14),
        gradeDropdown(),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: SectionHeading(
                title: 'كتب صفك',
                subtitle: selectedGrade,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: gradeColor(selectedGrade).withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${visibleBooks.length} كتاب',
                style: TextStyle(
                  color: gradeColor(selectedGrade),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          controller: searchController,
          onChanged: (value) => setState(() => search = value),
          decoration: InputDecoration(
            hintText: 'ابحث عن كتاب أو مادة...',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: search.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      searchController.clear();
                      setState(() => search = '');
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
          ),
        ),
        const SizedBox(height: 18),
        if (visibleBooks.isEmpty)
          const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'ما لقينا نتائج',
            subtitle: 'جرّب كلمة بحث ثانية.',
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibleBooks.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: wide ? 3 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 155,
            ),
            itemBuilder: (context, index) {
              final book = visibleBooks[index];
              return BookCard(
                book: book,
                favorite: favorites.contains(book.key),
                onFavorite: () => toggleFavorite(book),
                onTap: () => openBook(book),
                onDownload: () => downloadBook(book),
              );
            },
          ),
        const SizedBox(height: 22),
        const Center(
          child: Text(
            'مكتبة المناهج العراقية',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget gradeDropdown() {
    final color = gradeColor(selectedGrade);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.09),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(21),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    gradeIcon(selectedGrade),
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gradeStage(selectedGrade),
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        selectedGrade,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.expand_more_rounded, color: color, size: 29),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedGrade,
                isExpanded: true,
                borderRadius: BorderRadius.circular(18),
                dropdownColor: Theme.of(context).cardColor,
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: color),
                hint: const Text('اختر الصف الدراسي'),
                items: [
                  ..._stageHeader('المرحلة الابتدائية', teal),
                  ..._stageGrades(grades.take(6), teal),
                  ..._stageHeader('المرحلة المتوسطة', blue),
                  ..._stageGrades(grades.skip(6).take(3), blue),
                  ..._stageHeader('المرحلة الإعدادية', purple),
                  ..._stageGrades(grades.skip(9), purple),
                ],
                onChanged: (value) {
                  if (value == null || !grades.contains(value)) return;
                  setState(() {
                    selectedGrade = value;
                    search = '';
                    searchController.clear();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _stageHeader(
    String title,
    Color color,
  ) {
    return [
      DropdownMenuItem<String>(
        enabled: false,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 7),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<DropdownMenuItem<String>> _stageGrades(
    Iterable<String> stageGrades,
    Color color,
  ) {
    return stageGrades.map((grade) {
      final selected = grade == selectedGrade;

      return DropdownMenuItem<String>(
        value: grade,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.10) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(gradeIcon(grade), color: color, size: 19),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  grade,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.w900 : FontWeight.w500,
                    color: selected ? color : null,
                    fontSize: 13,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded, color: color, size: 20),
            ],
          ),
        ),
      );
    }).toList();
  }

  // بطاقة رئيسية أقل ارتفاعاً
  Widget heroBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF173B68), Color(0xFF2864E8)],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -6,
            bottom: -12,
            child: Icon(
              Icons.auto_stories_rounded,
              size: 100,
              color: Colors.white.withOpacity(0.10),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'مساحة تعلّمك',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'كل كتبك الدراسية،\nفي مكان واحد.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'نظّم دراستك وخلّ وصولك للمعلومة أسهل.',
                style: TextStyle(color: Color(0xFFDCE7FF), fontSize: 12),
              ),
              const SizedBox(height: 10),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: navy,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
                onPressed: () {
                  setState(() {
                    page = 0;
                    search = '';
                    searchController.clear();
                  });
                },
                icon: const Icon(Icons.menu_book_rounded, size: 18),
                label: const Text(
                  'تصفّح الكتب',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFavorites(bool wide) {
    final items = books
        .where((book) => favorites.contains(book.key))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(
          title: 'كتبك المفضلة',
          subtitle: 'الكتب التي حفظتها للوصول السريع',
        ),
        const SizedBox(height: 20),
        if (items.isEmpty)
          const EmptyState(
            icon: Icons.favorite_border_rounded,
            title: 'قائمتك فارغة حالياً',
            subtitle: 'اضغط على القلب في أي كتاب لإضافته هنا.',
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: wide ? 3 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 155,
            ),
            itemBuilder: (context, index) {
              final book = items[index];
              return BookCard(
                book: book,
                favorite: true,
                onFavorite: () => toggleFavorite(book),
                onTap: () => openBook(book),
                onDownload: () => downloadBook(book),
              );
            },
          ),
      ],
    );
  }

  Widget buildExams() {
    const examSubjects = [
      ('الرياضيات', Icons.calculate_rounded, blue),
      ('اللغة العربية', Icons.menu_book_rounded, purple),
      ('العلوم', Icons.science_rounded, teal),
      ('اللغة الإنكليزية', Icons.translate_rounded, Color(0xFFEC9142)),
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(
          title: 'مركز الاختبارات',
          subtitle: 'راجع معلوماتك واستعد للامتحان',
        ),
        const SizedBox(height: 20),
        ...examSubjects.map((item) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item.$3.withOpacity(0.13),
                child: Icon(item.$2, color: item.$3),
              ),
              title: Text(
                item.$1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('اختبار تجريبي'),
              trailing: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text('اختبار ${item.$1}'),
                    content: const Text(
                      'يمكن إضافة الأسئلة والتصحيح التلقائي '
                      'إلى هذا القسم في مرحلة لاحقة.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('حسناً'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildNotes() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(
          title: 'ملاحظاتي',
          subtitle: 'دوّن أفكارك ومعلوماتك المهمة',
        ),
        const SizedBox(height: 18),
        TextField(
          controller: noteController,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'اكتب ملاحظة أو واجباً تريد تذكّره...',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () {
            final text = noteController.text.trim();
            if (text.isEmpty) return;
            setState(() {
              notes.insert(0, text);
              noteController.clear();
            });
            FocusScope.of(context).unfocus();
          },
          icon: const Icon(Icons.add_rounded),
          label: const Text('إضافة ملاحظة'),
        ),
        const SizedBox(height: 20),
        if (notes.isEmpty)
          const EmptyState(
            icon: Icons.sticky_note_2_outlined,
            title: 'لا توجد ملاحظات',
            subtitle: 'ابدأ بتدوين أول ملاحظة دراسية.',
          )
        else
          ...notes.asMap().entries.map((entry) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.notes_rounded, color: blue),
                title: Text(entry.value),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () {
                    setState(() => notes.removeAt(entry.key));
                  },
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget buildSettings() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(
          title: 'الإعدادات',
          subtitle: 'خصص تجربتك الدراسية',
        ),
        const SizedBox(height: 20),
        Card(
          child: SwitchListTile(
            secondary: const Icon(Icons.dark_mode_rounded),
            title: const Text('الوضع الليلي'),
            subtitle: const Text('مظهر داكن مريح للعين'),
            value: widget.dark,
            onChanged: widget.onDarkChanged,
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.school_rounded),
            title: Text('مكتبة المناهج العراقية'),
            subtitle: Text('نسخة تجريبية قابلة للتطوير'),
          ),
        ),
      ],
    );
  }

  void toggleFavorite(SchoolBook book) {
    setState(() {
      if (favorites.contains(book.key)) {
        favorites.remove(book.key);
      } else {
        favorites.add(book.key);
      }
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void downloadBook(SchoolBook book) {
    if (book.url.isEmpty) {
      showMessage('رابط تحميل هذا الكتاب غير متوفر حالياً.');
      return;
    }

    final match = RegExp(r'/d/([^/]+)').firstMatch(book.url);

    if (match != null) {
      final fileId = match.group(1)!;
      final downloadUrl =
          'https://drive.google.com/uc?export=download&id=$fileId';
      html.window.open(downloadUrl, '_blank');
    } else {
      html.window.open(book.url, '_blank');
    }
  }

  void openBook(SchoolBook book) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final isFavorite = favorites.contains(book.key);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 58,
                            height: 66,
                            decoration: BoxDecoration(
                              color: subjectColor(book.subject)
                                  .withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              subjectIcon(book.subject),
                              size: 30,
                              color: subjectColor(book.subject),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(book.grade),
                                const SizedBox(height: 3),
                                Text(
                                  book.subject,
                                  style: TextStyle(
                                    color: subjectColor(book.subject),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Text(
                        book.url.isEmpty
                            ? 'لم تتم إضافة رابط لهذا الكتاب بعد.'
                            : 'يمكنك فتح الكتاب أو محاولة تحميله.',
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 5,
                                ),
                              ),
                              onPressed: () {
                                if (book.url.isEmpty) {
                                  showMessage(
                                    'رابط هذا الكتاب غير متوفر حالياً.',
                                  );
                                  return;
                                }
                                Navigator.pop(sheetContext);
                                html.window.open(book.url, '_blank');
                              },
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.menu_book_rounded, size: 19),
                                  SizedBox(height: 4),
                                  Text('فتح الكتاب'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 5,
                                ),
                              ),
                              onPressed: () => downloadBook(book),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.download_rounded, size: 19),
                                  SizedBox(height: 4),
                                  Text('تحميل'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 3,
                                ),
                              ),
                              onPressed: () {
                                toggleFavorite(book);
                                setSheetState(() {});
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isFavorite
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    size: 19,
                                    color: isFavorite
                                        ? Colors.redAccent
                                        : null,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isFavorite ? 'إزالة' : 'المفضلة',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
  final SchoolBook book;
  final bool favorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;
  final VoidCallback onDownload;

  const BookCard({
    super.key,
    required this.book,
    required this.favorite,
    required this.onFavorite,
    required this.onTap,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    final color = subjectColor(book.subject);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 39,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      subjectIcon(book.subject),
                      color: color,
                      size: 23,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 35,
                    height: 38,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      onPressed: onFavorite,
                      tooltip: favorite
                          ? 'إزالة من المفضلة'
                          : 'إضافة إلى المفضلة',
                      icon: Icon(
                        favorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: favorite ? Colors.redAccent : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                book.grade,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        minimumSize: const Size(0, 29),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      icon: const Icon(Icons.open_in_new_rounded, size: 14),
                      label: const Text(
                        'فتح',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: onDownload,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        minimumSize: const Size(0, 29),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      icon: const Icon(Icons.download_rounded, size: 15),
                      label: const Text(
                        'تحميل',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeading({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: blue.withOpacity(0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 37, color: blue),
          ),
          const SizedBox(height: 17),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
