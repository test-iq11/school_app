
import 'package:flutter/material.dart';

void main() => runApp(const IraqiBooksApp());

const green = Color(0xFF087F72);
const ink = Color(0xFF18302E);
const canvas = Color(0xFFF5F8F8);

class IraqiBooksApp extends StatelessWidget {
  const IraqiBooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مكتبة المناهج العراقية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        scaffoldBackgroundColor: canvas,
        appBarTheme: const AppBarTheme(
          backgroundColor: green,
          foregroundColor: Colors.white,
          centerTitle: true,
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

class Book {
  final String name;
  final String url;
  bool favorite;

  Book(this.name, {this.url = '', this.favorite = false});
}

class Grade {
  final String name;
  final List<Book> books;

  Grade(this.name, this.books);
}

class Stage {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<Grade> grades;

  Stage({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.grades,
  });
}

Grade makeGrade(String name, List<String> subjects) {
  return Grade(name, subjects.map((s) => Book(s)).toList());
}

const primarySubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'الرياضيات',
  'العلوم',
  'الاجتماعيات',
  'اللغة الإنكليزية',
];

const middleSubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'الرياضيات',
  'العلوم',
  'الاجتماعيات',
  'اللغة الإنكليزية',
  'الحاسوب',
];

const scienceSubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنكليزية',
  'الرياضيات',
  'الفيزياء',
  'الكيمياء',
  'الأحياء',
  'الحاسوب',
];

const literarySubjects = [
  'التربية الإسلامية',
  'اللغة العربية',
  'اللغة الإنكليزية',
  'التاريخ',
  'الجغرافية',
  'الرياضيات',
  'الأدب والنصوص',
  'الحاسوب',
];

final List<Stage> stages = [
  Stage(
    name: 'المرحلة الابتدائية',
    subtitle: 'من الصف الأول إلى الصف السادس',
    icon: Icons.backpack_rounded,
    color: const Color(0xFFF0A72E),
    grades: [
      Grade('الصف الأول الابتدائي', [
        Book('القرآن الكريم والتربية الإسلامية',
            url: 'https://drive.google.com/file/d/1idf1IS_S_XcSXCoDFb59tpaH41hyYEzu/view?usp=sharing'),
        Book('قراءتي (اللغة العربية)',
            url: 'https://mlazemna.com/1bpr19/'),
        Book('كتاب نشاط القراءة (التمرينات)',
            url: 'https://mlazemna.com/mbkyarn/'),
        Book('اللغة الإنكليزية (كتاب الطالب والنشاط)',
            url: 'https://mlazemna.com/bk1pr/'),
        Book('الرياضيات (كتاب التلميذ والتمرينات)',
            url: 'https://mlazemna.com/bk1pr/'),
        Book('العلوم (كتاب التلميذ والنشاط)',
            url: 'https://mlazemna.com/bk1pr/'),
        Book('التربية الأخلاقية',
            url: 'https://mlazemna.com/1bpr19/'),
      ]),
      makeGrade('الصف الثاني الابتدائي', primarySubjects),
      makeGrade('الصف الثالث الابتدائي', middleSubjects),
      makeGrade('الصف الرابع الابتدائي', middleSubjects),
      makeGrade('الصف الخامس الابتدائي', middleSubjects),
      makeGrade('الصف السادس الابتدائي', middleSubjects),
    ],
  ),
  Stage(
    name: 'المرحلة المتوسطة',
    subtitle: 'من الصف الأول إلى الصف الثالث',
    icon: Icons.menu_book_rounded,
    color: const Color(0xFF168C83),
    grades: [
      makeGrade('الصف الأول المتوسط', middleSubjects),
      makeGrade('الصف الثاني المتوسط', [
        'التربية الإسلامية',
        'اللغة العربية',
        'الرياضيات',
        'الفيزياء',
        'الكيمياء',
        'الأحياء',
        'الاجتماعيات',
        'اللغة الإنكليزية',
        'الحاسوب',
      ]),
      makeGrade('الصف الثالث المتوسط', [
        'التربية الإسلامية',
        'اللغة العربية',
        'الرياضيات',
        'الفيزياء',
        'الكيمياء',
        'الأحياء',
        'الاجتماعيات',
        'اللغة الإنكليزية',
        'الحاسوب',
      ]),
    ],
  ),
  Stage(
    name: 'الإعدادية — الفرع العلمي',
    subtitle: 'الرابع والخامس والسادس العلمي',
    icon: Icons.science_rounded,
    color: const Color(0xFF5368C8),
    grades: [
      makeGrade('الصف الرابع الإعدادي — العلمي', scienceSubjects),
      makeGrade('الصف الخامس الإعدادي — العلمي', scienceSubjects),
      makeGrade('الصف السادس الإعدادي — العلمي', scienceSubjects),
    ],
  ),
  Stage(
    name: 'الإعدادية — الفرع الأدبي',
    subtitle: 'الرابع والخامس والسادس الأدبي',
    icon: Icons.auto_stories_rounded,
    color: const Color(0xFF8654B7),
    grades: [
      makeGrade('الصف الرابع الإعدادي — الأدبي', literarySubjects),
      makeGrade('الصف الخامس الإعدادي — الأدبي', [
        'التربية الإسلامية',
        'اللغة العربية',
        'اللغة الإنكليزية',
        'التاريخ الحديث والمعاصر',
        'الجغرافية البشرية والاقتصادية',
        'الرياضيات',
        'الأدب والنصوص',
        'الحاسوب',
      ]),
      makeGrade('الصف السادس الإعدادي — الأدبي', literarySubjects),
    ],
  ),
];

List<Book> get allBooks =>
    stages.expand((s) => s.grades).expand((g) => g.books).toList();

void showBookLink(BuildContext context, Book book,
    {bool download = false}) {
  if (book.url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('رابط هذا الكتاب غير متوفر حالياً.'),
      ),
    );
    return;
  }

  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(download ? 'رابط تحميل الكتاب' : 'عرض الكتاب'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.name),
            const SizedBox(height: 12),
            const Text('انسخ الرابط وافتحه في المتصفح:'),
            const SizedBox(height: 12),
            SelectableText(
              book.url,
              textDirection: TextDirection.ltr,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('إغلاق'),
        ),
      ],
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  String query = '';
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = allBooks.where((b) {
      return b.name.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مكتبة المناهج العراقية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: tab == 0 ? homeBody(results) : favoritesBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
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
        ],
      ),
    );
  }

  Widget homeBody(List<Book> results) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF087F72), Color(0xFF07574F)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.school_rounded,
                  color: Colors.white, size: 38),
              SizedBox(height: 14),
              Text(
                'كل كتبك الدراسية في مكان واحد',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'اختر مرحلتك وصفك للوصول إلى المواد الدراسية.',
                style: TextStyle(color: Colors.white70, height: 1.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: controller,
          textDirection: TextDirection.rtl,
          onChanged: (v) => setState(() => query = v),
          decoration: InputDecoration(
            hintText: 'ابحث عن كتاب أو مادة أو صف...',
            prefixIcon: const Icon(Icons.search_rounded, color: green),
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      controller.clear();
                      setState(() => query = '');
                    },
                    icon: const Icon(Icons.close),
                  ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'المراحل الدراسية',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        const SizedBox(height: 12),
        if (query.isNotEmpty)
          if (results.isEmpty)
            const EmptyState(
              title: 'لا توجد نتائج',
              subtitle: 'جرّب كلمة بحث مختلفة.',
              icon: Icons.search_off_rounded,
            )
          else
            ...results.map(
              (book) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BookTile(
                  book: book,
                  onFavorite: () => setState(
                    () => book.favorite = !book.favorite,
                  ),
                ),
              ),
            )
        else
          ...stages.map(
            (stage) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: StageCard(
                stage: stage,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GradesScreen(stage: stage),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        const Text(
          'تنبيه: قد تختلف الكتب حسب الطبعة والسنة الدراسية.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  Widget favoritesBody() {
    final favorites = allBooks.where((b) => b.favorite).toList();

    if (favorites.isEmpty) {
      return const EmptyState(
        icon: Icons.favorite_border_rounded,
        title: 'قائمة المفضلة فارغة',
        subtitle: 'اضغط على القلب بجانب أي كتاب لإضافته هنا.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) => BookTile(
        book: favorites[i],
        onFavorite: () => setState(
          () => favorites[i].favorite = false,
        ),
      ),
    );
  }
}

class StageCard extends StatelessWidget {
  const StageCard({
    super.key,
    required this.stage,
    required this.onTap,
  });

  final Stage stage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final count = stage.grades.fold<int>(
      0,
      (sum, grade) => sum + grade.books.length,
    );

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE6EEEC)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: stage.color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(stage.icon, color: stage.color, size: 30),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stage.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      stage.subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      '${stage.grades.length} صفوف • $count مادة',
                      style: TextStyle(
                        color: stage.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key, required this.stage});

  final Stage stage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stage.name)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: stage.grades.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final grade = stage.grades[i];

          return Card(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: stage.color.withOpacity(0.13),
                foregroundColor: stage.color,
                child: Text('${i + 1}'),
              ),
              title: Text(grade.name),
              subtitle: Text('${grade.books.length} مواد دراسية'),
              trailing: const Icon(Icons.chevron_left_rounded),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubjectsScreen(grade: grade),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key, required this.grade});

  final Grade grade;

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    final books = widget.grade.books.where((b) {
      return b.name.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.grade.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              textDirection: TextDirection.rtl,
              onChanged: (v) => setState(() => filter = v),
              decoration: InputDecoration(
                hintText: 'ابحث داخل مواد الصف...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'لا توجد مواد مطابقة',
                    subtitle: 'غيّر عبارة البحث وحاول مرة أخرى.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: books.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, i) => BookTile(
                      book: books[i],
                      onFavorite: () => setState(
                        () => books[i].favorite = !books[i].favorite,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    required this.onFavorite,
  });

  final Book book;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final hasLink = book.url.isNotEmpty;

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE6EEEC)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: green.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: green),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasLink
                            ? 'الرابط متوفر'
                            : 'الرابط غير متوفر حالياً',
                        style: TextStyle(
                          color: hasLink ? green : Colors.orange.shade800,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: book.favorite
                      ? 'إزالة من المفضلة'
                      : 'إضافة للمفضلة',
                  onPressed: onFavorite,
                  icon: Icon(
                    book.favorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: book.favorite ? Colors.redAccent : Colors.black38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => showBookLink(context, book),
                    icon: const Icon(Icons.visibility_rounded, size: 18),
                    label: const Text('عرض الكتاب'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: green,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () =>
                        showBookLink(context, book, download: true),
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('تحميل الكتاب'),
                    style: FilledButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: green.withOpacity(0.55)),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
