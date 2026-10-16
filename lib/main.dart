
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
        fontFamily: 'Roboto',
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}

class SchoolSubject {
  SchoolSubject({
    required this.title,
    required this.stage,
    required this.grade,
    this.url = '',
    this.isFavorite = false,
  });

  final String title;
  final String stage;
  final String grade;
  final String url;
  bool isFavorite;
}

class SchoolGrade {
  SchoolGrade({
    required this.title,
    required this.stage,
    required this.number,
    required this.color,
    required this.subjects,
  });

  final String title;
  final String stage;
  final int number;
  final Color color;
  final List<SchoolSubject> subjects;
}

class SchoolStage {
  SchoolStage({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.grades,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<SchoolGrade> grades;
}

List<SchoolSubject> makeSubjects(
  String stage,
  String grade,
  List<String> titles, {
  Map<String, String> links = const {},
}) {
  return titles
      .map((title) => SchoolSubject(
            title: title,
            stage: stage,
            grade: grade,
            url: links[title] ?? '',
          ))
      .toList();
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

SchoolGrade makeGrade(
  String stage,
  String title,
  int number,
  Color color,
  List<String> subjects,
) {
  return SchoolGrade(
    title: title,
    stage: stage,
    number: number,
    color: color,
    subjects: makeSubjects(stage, title, subjects),
  );
}

final List<SchoolStage> schoolStages = [
  SchoolStage(
    title: 'المرحلة الابتدائية',
    subtitle: 'من الصف الأول إلى الصف السادس',
    icon: Icons.backpack_rounded,
    color: const Color(0xFFF0A72E),
    grades: [
      SchoolGrade(
        title: 'الصف الأول الابتدائي',
        stage: 'الابتدائية',
        number: 1,
        color: const Color(0xFFF0A72E),
        subjects: makeSubjects(
          'الابتدائية',
          'الأول الابتدائي',
          [
            'القرآن الكريم والتربية الإسلامية',
            'قراءتي (اللغة العربية)',
            'كتاب نشاط القراءة (التمرينات)',
            'اللغة الإنكليزية (كتاب الطالب والنشاط)',
            'الرياضيات (كتاب التلميذ والتمرينات)',
            'العلوم (كتاب التلميذ والنشاط)',
            'التربية الأخلاقية',
          ],
          links: {
            'القرآن الكريم والتربية الإسلامية':
                'https://drive.google.com/file/d/1idf1IS_S_XcSXCoDFb59tpaH41hyYEzu/view?usp=sharing',
            'قراءتي (اللغة العربية)': 'https://mlazemna.com/1bpr19/',
            'كتاب نشاط القراءة (التمرينات)':
                'https://mlazemna.com/mbkyarn/',
            'اللغة الإنكليزية (كتاب الطالب والنشاط)':
                'https://mlazemna.com/bk1pr/',
            'الرياضيات (كتاب التلميذ والتمرينات)':
                'https://mlazemna.com/bk1pr/',
            'العلوم (كتاب التلميذ والنشاط)':
                'https://mlazemna.com/bk1pr/',
            'التربية الأخلاقية': 'https://mlazemna.com/1bpr19/',
          },
        ),
      ),
      makeGrade('الابتدائية', 'الصف الثاني الابتدائي', 2,
          const Color(0xFFF0A72E), primarySubjects),
      makeGrade('الابتدائية', 'الصف الثالث الابتدائي', 3,
          const Color(0xFFF0A72E), middleSubjects),
      makeGrade('الابتدائية', 'الصف الرابع الابتدائي', 4,
          const Color(0xFFF0A72E), middleSubjects),
      makeGrade('الابتدائية', 'الصف الخامس الابتدائي', 5,
          const Color(0xFFF0A72E), middleSubjects),
      makeGrade('الابتدائية', 'الصف السادس الابتدائي', 6,
          const Color(0xFFF0A72E), middleSubjects),
    ],
  ),
  SchoolStage(
    title: 'المرحلة المتوسطة',
    subtitle: 'من الصف الأول إلى الصف الثالث',
    icon: Icons.menu_book_rounded,
    color: const Color(0xFF168C83),
    grades: [
      makeGrade('المتوسطة', 'الصف الأول المتوسط', 1,
          const Color(0xFF168C83), middleSubjects),
      makeGrade(
        'المتوسطة',
        'الصف الثاني المتوسط',
        2,
        const Color(0xFF168C83),
        [
          'التربية الإسلامية',
          'اللغة العربية',
          'الرياضيات',
          'الفيزياء',
          'الكيمياء',
          'الأحياء',
          'الاجتماعيات',
          'اللغة الإنكليزية',
          'الحاسوب',
        ],
      ),
      makeGrade(
        'المتوسطة',
        'الصف الثالث المتوسط',
        3,
        const Color(0xFF168C83),
        [
          'التربية الإسلامية',
          'اللغة العربية',
          'الرياضيات',
          'الفيزياء',
          'الكيمياء',
          'الأحياء',
          'الاجتماعيات',
          'اللغة الإنكليزية',
          'الحاسوب',
        ],
      ),
    ],
  ),
  SchoolStage(
    title: 'الإعدادية — الفرع العلمي',
    subtitle: 'الرابع والخامس والسادس العلمي',
    icon: Icons.science_rounded,
    color: const Color(0xFF5368C8),
    grades: [
      makeGrade('الإعدادية / العلمي', 'الصف الرابع الإعدادي — العلمي',
          4, const Color(0xFF5368C8), scienceSubjects),
      makeGrade('الإعدادية / العلمي', 'الصف الخامس الإعدادي — العلمي',
          5, const Color(0xFF5368C8), scienceSubjects),
      makeGrade('الإعدادية / العلمي', 'الصف السادس الإعدادي — العلمي',
          6, const Color(0xFF5368C8), scienceSubjects),
    ],
  ),
  SchoolStage(
    title: 'الإعدادية — الفرع الأدبي',
    subtitle: 'الرابع والخامس والسادس الأدبي',
    icon: Icons.auto_stories_rounded,
    color: const Color(0xFF8654B7),
    grades: [
      makeGrade('الإعدادية / الأدبي', 'الصف الرابع الإعدادي — الأدبي',
          4, const Color(0xFF8654B7), literarySubjects),
      makeGrade('الإعدادية / الأدبي', 'الصف الخامس الإعدادي — الأدبي',
          5,
          const Color(0xFF8654B7),
          [
            'التربية الإسلامية',
            'اللغة العربية',
            'اللغة الإنكليزية',
            'التاريخ الحديث والمعاصر',
            'الجغرافية البشرية والاقتصادية',
            'الرياضيات',
            'الأدب والنصوص',
            'الحاسوب',
          ]),
      makeGrade('الإعدادية / الأدبي', 'الصف السادس الإعدادي — الأدبي',
          6, const Color(0xFF8654B7), literarySubjects),
    ],
  ),
];

List<SchoolSubject> get allSubjects => schoolStages
    .expand((stage) => stage.grades)
    .expand((grade) => grade.subjects)
    .toList();

void showBookLink(
  BuildContext context,
  SchoolSubject subject, {
  bool download = false,
}) {
  final url = subject.url.trim();

  if (url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('رابط هذا الكتاب غير متوفر حالياً.'),
      ),
    );
    return;
  }

  final uri = Uri.tryParse(url);
  if (uri == null ||
      !uri.hasAuthority ||
      (uri.scheme != 'https' && uri.scheme != 'http')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('رابط الكتاب غير صالح.')),
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
            Text(subject.title),
            const SizedBox(height: 12),
            const Text('انسخ الرابط وافتحه في المتصفح:'),
            const SizedBox(height: 12),
            SelectableText(
              url,
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
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = allSubjects.where((subject) {
      final text =
          '${subject.title} ${subject.grade} ${subject.stage}'.toLowerCase();
      return text.contains(query.trim().toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مكتبة المناهج العراقية',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: tab == 0
          ? homeContent(results)
          : favoritesContent(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) => setState(() => tab = index),
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

  Widget homeContent(List<SchoolSubject> results) {
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
                  color: Colors.white, size: 36),
              SizedBox(height: 14),
              Text(
                'كل كتبك الدراسية في مكان واحد',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
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
          controller: searchController,
          onChanged: (value) => setState(() => query = value),
          decoration: InputDecoration(
            hintText: 'ابحث عن كتاب أو مادة أو صف...',
            prefixIcon: const Icon(Icons.search_rounded, color: green),
            suffixIcon: query.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      searchController.clear();
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
            fontWeight: FontWeight.w800,
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
              (subject) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SubjectTile(
                  subject: subject,
                  onFavorite: () => setState(
                    () => subject.isFavorite = !subject.isFavorite,
                  ),
                ),
              ),
            )
        else
          ...schoolStages.map(
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
          'تنبيه: قد تختلف الكتب حسب الطبعة والمنهج المعتمد للسنة الدراسية.',
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  Widget favoritesContent() {
    final favorites =
        allSubjects.where((subject) => subject.isFavorite).toList();

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
      itemBuilder: (context, index) => SubjectTile(
        subject: favorites[index],
        onFavorite: () => setState(
          () => favorites[index].isFavorite = false,
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

  final SchoolStage stage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final subjectCount = stage.grades.fold<int>(
      0,
      (sum, grade) => sum + grade.subjects.length,
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
                      stage.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
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
                      '${stage.grades.length} صفوف • $subjectCount مادة',
                      style: TextStyle(
                        color: stage.color,
                        fontWeight: FontWeight.w700,
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

  final SchoolStage stage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(stage.title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: stage.grades.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final grade = stage.grades[index];

          return Card(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: grade.color.withOpacity(0.13),
                foregroundColor: grade.color,
                child: Text('${grade.number}'),
              ),
              title: Text(
                grade.title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text('${grade.subjects.length} مواد دراسية'),
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

  final SchoolGrade grade;

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  String filter = '';

  @override
  Widget build(BuildContext context) {
    final subjects = widget.grade.subjects
        .where((subject) =>
            subject.title.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.grade.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => filter = value),
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
            child: subjects.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'لا توجد مواد مطابقة',
                    subtitle: 'غيّر عبارة البحث وحاول مرة أخرى.',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    itemCount: subjects.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) => SubjectTile(
                      subject: subjects[index],
                      onFavorite: () => setState(
                        () => subjects[index].isFavorite =
                            !subjects[index].isFavorite,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class SubjectTile extends StatelessWidget {
  const SubjectTile({
    super.key,
    required this.subject,
    required this.onFavorite,
  });

  final SchoolSubject subject;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    final hasLink = subject.url.isNotEmpty;

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
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${subject.stage} • ${subject.grade}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 11,
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
                  tooltip:
                      subject.isFavorite ? 'إزالة من المفضلة' : 'إضافة للمفضلة',
                  onPressed: onFavorite,
                  icon: Icon(
                    subject.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: subject.isFavorite
                        ? Colors.redAccent
                        : Colors.black38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => showBookLink(context, subject),
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
                        showBookLink(context, subject, download: true),
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
                fontWeight: FontWeight.w800,
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
