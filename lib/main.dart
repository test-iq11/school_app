import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
runApp(const SchoolBooksApp());
}

class SchoolBooksApp extends StatelessWidget {
const SchoolBooksApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'مكتبة المناهج العراقية الذكية',
debugShowCheckedModeBanner: false,
theme: ThemeData(
useMaterial3: true,
colorScheme: ColorScheme.fromSeed(
seedColor: const Color(0xFF00796B),
primary: const Color(0xFF00796B),
secondary: const Color(0xFF009688),
),
fontFamily: 'Cairo',
scaffoldBackgroundColor: const Color(0xFFF4F6F8),
),
locale: const Locale('ar', 'IQ'),
builder: (context, child) {
return Directionality(
textDirection: TextDirection.rtl,
child: child!,
);
},
home: const MainHomeScreen(),
);
}
}

// ==========================================
// 1. نماذج البيانات (Data Models)
// ==========================================
class Subject {
final String title;
final String stageName;
final String className;
final String bookUrl;
final String fileSize;
bool isFavorite;

Subject({
required this.title,
required this.stageName,
required this.className,
required this.bookUrl,
required this.fileSize,
this.isFavorite = false,
});
}

class SchoolClass {
final String name;
final List<Subject> subjects;

SchoolClass({required this.name, required this.subjects});
}

class Stage {
final String name;
final String icon;
final Color color;
final List<SchoolClass> classes;

Stage({
required this.name,
required this.icon,
required this.color,
required this.classes,
});
}

// ==========================================
// 2. دالة فتح روابط الكتب المخصصة
// ==========================================
Future<void> openOrDownloadBook(BuildContext context, String url, String bookTitle) async {
if (url.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('عذراً، لم يتم إضافة رابط هذا الكتاب بعد!'),
backgroundColor: Colors.orange,
),
);
return;
}

final Uri uri = Uri.parse(url);
if (await canLaunchUrl(uri)) {
await launchUrl(uri, mode: LaunchMode.externalApplication);
} else {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('تعذر فتح رابط كتاب: $bookTitle'),
backgroundColor: Colors.red,
),
);
}
}

// ==========================================
// 3. البيانات الشاملة مع الروابط المخصصة لكل كتاب
// ==========================================
final List<Stage> educationalStages = [
Stage(
name: 'المرحلة الابتدائية',
icon: '🎒',
color: Colors.amber,
classes: [
SchoolClass(name: 'الصف الأول الابتدائي', subjects: [
Subject(
title: 'القرآن الكريم والتربية الإسلامية',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://drive.google.com/uc?export=download&id=11yKmb-5gvVC15RIznlr7Hyp9RAPab5YK',
fileSize: '15 MB',
),
Subject(
title: 'قراءتي (اللغة العربية)',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://mlazemna.com/1bpr19/',
fileSize: '18 MB',
),
Subject(
title: 'كتاب نشاط القراءة (التمرينات)',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://mlazemna.com/mbkyarn/',
fileSize: '4.1 MB',
),
Subject(
title: 'اللغة الإنكليزية (كتاب الطالب والنشاط)',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://mlazemna.com/bk1pr/',
fileSize: '22 MB',
),
Subject(
title: 'الرياضيات (كتاب التلميذ والتمرينات)',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://mlazemna.com/bk1pr/',
fileSize: '16 MB',
),
Subject(
title: 'العلوم (كتاب التلميذ والنشاط)',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://mlazemna.com/bk1pr/',
fileSize: '20 MB',
),
Subject(
title: 'التربية الأخلاقية (المنهج الجديد)',
stageName: 'الابتدائية',
className: 'الأول الابتدائي',
bookUrl: 'https://mlazemna.com/1bpr19/',
fileSize: '14 MB',
),
]),
SchoolClass(name: 'الصف الثاني الابتدائي', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'الابتدائية', className: 'الثاني الابتدائي', bookUrl: '', fileSize: '13 MB'),
Subject(title: 'القراءة', stageName: 'الابتدائية', className: 'الثاني الابتدائي', bookUrl: '', fileSize: '19 MB'),
Subject(title: 'الرياضيات', stageName: 'الابتدائية', className: 'الثاني الابتدائي', bookUrl: '', fileSize: '16 MB'),
]),
SchoolClass(name: 'الصف الثالث الابتدائي', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'الابتدائية', className: 'الثالث الابتدائي', bookUrl: '', fileSize: '14 MB'),
Subject(title: 'اللغة العربية والقراءة', stageName: 'الابتدائية', className: 'الثالث الابتدائي', bookUrl: '', fileSize: '20 MB'),
Subject(title: 'الرياضيات', stageName: 'الابتدائية', className: 'الثالث الابتدائي', bookUrl: '', fileSize: '17 MB'),
Subject(title: 'العلوم', stageName: 'الابتدائية', className: 'الثالث الابتدائي', bookUrl: '', fileSize: '21 MB'),
]),
SchoolClass(name: 'الصف الرابع الابتدائي', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'الابتدائية', className: 'الرابع الابتدائي', bookUrl: '', fileSize: '14 MB'),
Subject(title: 'اللغة العربية', stageName: 'الابتدائية', className: 'الرابع الابتدائي', bookUrl: '', fileSize: '21 MB'),
Subject(title: 'الرياضيات', stageName: 'الابتدائية', className: 'الرابع الابتدائي', bookUrl: '', fileSize: '18 MB'),
Subject(title: 'العلوم', stageName: 'الابتدائية', className: 'الرابع الابتدائي', bookUrl: '', fileSize: '22 MB'),
Subject(title: 'الاجتماعيات', stageName: 'الابتدائية', className: 'الرابع الابتدائي', bookUrl: '', fileSize: '15 MB'),
]),
SchoolClass(name: 'الصف الخامس الابتدائي', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'الابتدائية', className: 'الخامس الابتدائي', bookUrl: '', fileSize: '14 MB'),
Subject(title: 'اللغة العربية', stageName: 'الابتدائية', className: 'الخامس الابتدائي', bookUrl: '', fileSize: '22 MB'),
Subject(title: 'الرياضيات', stageName: 'الابتدائية', className: 'الخامس الابتدائي', bookUrl: '', fileSize: '19 MB'),
Subject(title: 'العلوم', stageName: 'الابتدائية', className: 'الخامس الابتدائي', bookUrl: '', fileSize: '23 MB'),
Subject(title: 'الاجتماعيات', stageName: 'الابتدائية', className: 'الخامس الابتدائي', bookUrl: '', fileSize: '16 MB'),
Subject(title: 'اللغة الإنجليزية', stageName: 'الابتدائية', className: 'الخامس الابتدائي', bookUrl: '', fileSize: '25 MB'),
]),
SchoolClass(name: 'الصف السادس الابتدائي', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'الابتدائية', className: 'السادس الابتدائي', bookUrl: '', fileSize: '15 MB'),
Subject(title: 'اللغة العربية', stageName: 'الابتدائية', className: 'السادس الابتدائي', bookUrl: '', fileSize: '24 MB'),
Subject(title: 'الرياضيات', stageName: 'الابتدائية', className: 'السادس الابتدائي', bookUrl: '', fileSize: '20 MB'),

ملازمنا
كتب الصف الاول الابتدائي 2026 pdf
كتب الصف الاول الابتدائي 2026 pdf كتب اول ابتدائي اسلامية علوم عربي انكليزي رياضيات اجتماعيات كتاب الاول ابتدائي المناهج الاول الابتدائي
Subject(title: 'العلوم', stageName: 'الابتدائية', className: 'السادس الابتدائي', bookUrl: '', fileSize: '25 MB'),
Subject(title: 'الاجتماعيات', stageName: 'الابتدائية', className: 'السادس الابتدائي', bookUrl: '', fileSize: '18 MB'),
Subject(title: 'اللغة الإنجليزية', stageName: 'الابتدائية', className: 'السادس الابتدائي', bookUrl: '', fileSize: '28 MB'),
]),
],
),
Stage(
name: 'المرحلة المتوسطة',
icon: '📖',
color: Colors.teal,
classes: [
SchoolClass(name: 'الصف الأول المتوسط', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'المتوسطة', className: 'الأول المتوسط', bookUrl: '', fileSize: '14 MB'),
Subject(title: 'قواعد اللغة العربية', stageName: 'المتوسطة', className: 'الأول المتوسط', bookUrl: '', fileSize: '18 MB'),
Subject(title: 'الرياضيات', stageName: 'المتوسطة', className: 'الأول المتوسط', bookUrl: '', fileSize: '26 MB'),
Subject(title: 'الأحياء', stageName: 'المتوسطة', className: 'الأول المتوسط', bookUrl: '', fileSize: '19 MB'),
Subject(title: 'الاجتماعيات', stageName: 'المتوسطة', className: 'الأول المتوسط', bookUrl: '', fileSize: '17 MB'),
Subject(title: 'اللغة الإنجليزية', stageName: 'المتوسطة', className: 'الأول المتوسط', bookUrl: '', fileSize: '30 MB'),
]),
SchoolClass(name: 'الصف الثاني المتوسط', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'المتوسطة', className: 'الثاني المتوسط', bookUrl: '', fileSize: '14 MB'),
Subject(title: 'قواعد اللغة العربية', stageName: 'المتوسطة', className: 'الثاني المتوسط', bookUrl: '', fileSize: '19 MB'),
Subject(title: 'الرياضيات', stageName: 'المتوسطة', className: 'الثاني المتوسط', bookUrl: '', fileSize: '27 MB'),
Subject(title: 'الفيزياء', stageName: 'المتوسطة', className: 'الثاني المتوسط', bookUrl: '', fileSize: '20 MB'),
Subject(title: 'الكيمياء', stageName: 'المتوسطة', className: 'الثاني المتوسط', bookUrl: '', fileSize: '17 MB'),
Subject(title: 'الأحياء', stageName: 'المتوسطة', className: 'الثاني المتوسط', bookUrl: '', fileSize: '21 MB'),
]),
SchoolClass(name: 'الصف الثالث المتوسط', subjects: [
Subject(title: 'التربية الإسلامية', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '15 MB'),
Subject(title: 'قواعد اللغة العربية', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '22 MB'),
Subject(title: 'الرياضيات', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '28 MB'),
Subject(title: 'الفيزياء', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '22 MB'),
Subject(title: 'الكيمياء', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '19 MB'),
Subject(title: 'الأحياء', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '24 MB'),
Subject(title: 'اللغة الإنجليزية', stageName: 'المتوسطة', className: 'الثالث المتوسط', bookUrl: '', fileSize: '32 MB'),
]),
],
),
Stage(
name: 'المرحلة الاعدادية (الفرع العلمي)',
icon: '🔬',
color: Colors.indigo,
classes: [
SchoolClass(name: 'الصف الرابع الاعدادي (العلمي)', subjects: [
Subject(title: 'الرياضيات (العلمي)', stageName: 'الاعدادية - العلمي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '28 MB'),
Subject(title: 'الفيزياء', stageName: 'الاعدادية - العلمي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '24 MB'),
Subject(title: 'الكيمياء', stageName: 'الاعدادية - العلمي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '21 MB'),
Subject(title: 'الأحياء', stageName: 'الاعدادية - العلمي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '25 MB'),
]),
SchoolClass(name: 'الصف الخامس الاعدادي (العلمي)', subjects: [
Subject(title: 'الرياضيات (العلمي)', stageName: 'الاعدادية - العلمي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '30 MB'),
Subject(title: 'الفيزياء', stageName: 'الاعدادية - العلمي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '26 MB'),
Subject(title: 'الكيمياء', stageName: 'الاعدادية - العلمي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '23 MB'),
Subject(title: 'الأحياء', stageName: 'الاعدادية - العلمي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '28 MB'),
]),
SchoolClass(name: 'الصف السادس الاعدادي (العلمي)', subjects: [
Subject(title: 'الرياضيات (السادس العلمي)', stageName: 'الاعدادية - العلمي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '35 MB'),
Subject(title: 'الفيزياء', stageName: 'الاعدادية - العلمي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '29 MB'),
Subject(title: 'الكيمياء', stageName: 'الاعدادية - العلمي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '25 MB'),
Subject(title: 'الأحياء (الإحيائي)', stageName: 'الاعدادية - العلمي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '31 MB'),
]),
],
),
Stage(
name: 'المرحلة الاعدادية (الفرع الأدبي)',
icon: '📚',
color: Colors.deepPurple,
classes: [
SchoolClass(name: 'الصف الرابع الاعدادي (الأدبي)', subjects: [
Subject(title: 'التاريخ', stageName: 'الاعدادية - الأدبي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '20 MB'),
Subject(title: 'الجغرافية', stageName: 'الاعدادية - الأدبي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '22 MB'),
Subject(title: 'قواعد اللغة العربية', stageName: 'الاعدادية - الأدبي', className: 'الرابع الاعدادي', bookUrl: '', fileSize: '19 MB'),
]),
SchoolClass(name: 'الصف الخامس الاعدادي (الأدبي)', subjects: [
Subject(title: 'التاريخ الحديث والمعاصر', stageName: 'الاعدادية - الأدبي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '23 MB'),
Subject(title: 'الجغرافية البشرية والاقتصادية', stageName: 'الاعدادية - الأدبي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '25 MB'),
Subject(title: 'الادب والنصوص', stageName: 'الاعدادية - الأدبي', className: 'الخامس الاعدادي', bookUrl: '', fileSize: '21 MB'),
]),
SchoolClass(name: 'الصف السادس الاعدادي (الأدبي)', subjects: [
Subject(title: 'التاريخ (السادس الأدبي)', stageName: 'الاعدادية - الأدبي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '28 MB'),
Subject(title: 'الجغرافية (السادس الأدبي)', stageName: 'الاعدادية - الأدبي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '26 MB'),
Subject(title: 'الادب والنصوص (السادس الأدبي)', stageName: 'الاعدادية - الأدبي', className: 'السادس الاعدادي', bookUrl: '', fileSize: '24 MB'),
]),
],
),
];

// ==========================================
// 4. الشاشة الرئيسية والتبويبات
// ==========================================
class MainHomeScreen extends StatefulWidget {
const MainHomeScreen({super.key});

@override
State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
int _currentIndex = 0;

List<Subject> get allSubjects {
List<Subject> list = [];
for (var stage in educationalStages) {
for (var c in stage.classes) {
list.addAll(c.subjects);
}
}
return list;
}

@override
Widget build(BuildContext context) {
final List<Widget> screens = [
const StagesHomeTab(),
FavoritesTab(subjects: allSubjects),
];

return Scaffold(
body: screens[_currentIndex],
bottomNavigationBar: NavigationBar(
selectedIndex: _currentIndex,
onDestinationSelected: (index) {
setState(() {
_currentIndex = index;
});
},
destinations: const [
NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
NavigationDestination(icon: Icon(Icons.favorite_outline), selectedIcon: Icon(Icons.favorite, color: Colors.red), label: 'المفضلة'),
],
),
);
}
}

class StagesHomeTab extends StatelessWidget {
const StagesHomeTab({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('مكتبة المناهج العراقية', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
centerTitle: true,
backgroundColor: const Color(0xFF00796B),
elevation: 0,
actions: [
IconButton(
icon: const Icon(Icons.search, color: Colors.white),
onPressed: () {
List<Subject> all = [];
for (var s in educationalStages) {
for (var c in s.classes) {
all.addAll(c.subjects);
}
}
showSearch(context: context, delegate: BookSearchDelegate(allSubjects: all));
},
)
],
),
body: ListView(
padding: const EdgeInsets.all(16.0),
children: [
Container(
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [Color(0xFF00796B), Color(0xFF004D40)],
begin: Alignment.topRight,
end: Alignment.bottomLeft,
),
borderRadius: BorderRadius.circular(16),
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('أهلاً بك عزيزي الطالب 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
SizedBox(height: 8),
Text('اضغط على أزرار الكتب للوصول إلى صفحات التنزيل المباشرة.', style: TextStyle(color: Colors.white70, fontSize: 14)),
],
),
),
const SizedBox(height: 20),
const Text('المراحل الدراسية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
const SizedBox(height: 12),
...educationalStages.map((stage) {
return Card(
elevation: 2,
margin: const EdgeInsets.only(bottom: 14),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
child: InkWell(
borderRadius: BorderRadius.circular(14),
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen(stage: stage)));
},
child: Padding(
padding: const EdgeInsets.all(18.0),
child: Row(
children: [
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(color: stage.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
child: Text(stage.icon, style: const TextStyle(fontSize: 32)),
),
const SizedBox(width: 16),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(stage.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
Text('${stage.classes.length} صفوف دراسية متوفرة', style: const TextStyle(color: Colors.grey, fontSize: 13)),
],
),
),
const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
],
),
),
),
);
}),
],
),
);
}
}

class ClassesScreen extends StatelessWidget {
final Stage stage;
const ClassesScreen({super.key, required this.stage});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(stage.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
backgroundColor: const Color(0xFF00796B),
iconTheme: const IconThemeData(color: Colors.white),
),
body: ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: stage.classes.length,
itemBuilder: (context, index) {
final c = stage.classes[index];
return Card(
elevation: 1,
margin: const EdgeInsets.only(bottom: 12),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
child: ListTile(
leading: const Icon(Icons.menu_book, color: Color(0xFF00796B)),
title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectsScreen(schoolClass: c)));
},
),
);
},
),
);
}
}

class SubjectsScreen extends StatefulWidget {
final SchoolClass schoolClass;
const SubjectsScreen({super.key, required this.schoolClass});

@override
State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(widget.schoolClass.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
backgroundColor: const Color(0xFF00796B),
iconTheme: const IconThemeData(color: Colors.white),
),
body: ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: widget.schoolClass.subjects.length,
itemBuilder: (context, index) {
final subject = widget.schoolClass.subjects[index];
return Card(
elevation: 2,
margin: const EdgeInsets.only(bottom: 16),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: [
Row(
children: [
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(color: const Color(0xFF00796B).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
child: const Icon(Icons.picture_as_pdf, color: Color(0xFF00796B), size: 26),
),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(subject.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
Text('الحجم: ${subject.fileSize}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
],
),
),
IconButton(
icon: Icon(subject.isFavorite ? Icons.favorite : Icons.favorite_border, color: subject.isFavorite ? Colors.red : Colors.grey),
onPressed: () {
setState(() {
subject.isFavorite = !subject.isFavorite;
});
},
),
],
),
const SizedBox(height: 14),
const Divider(height: 1),
const SizedBox(height: 12),
Row(
children: [
Expanded(
child: OutlinedButton.icon(
style: OutlinedButton.styleFrom(
foregroundColor: const Color(0xFF00796B),
side: const BorderSide(color: Color(0xFF00796B)),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
),
onPressed: () {
openOrDownloadBook(context, subject.bookUrl, subject.title);
},
icon: const Icon(Icons.visibility, size: 18),
label: const Text('قراءة'),
),
),
const SizedBox(width: 12),
Expanded(
child: ElevatedButton.icon(
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFF00796B),
foregroundColor: Colors.white,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
),
onPressed: () {
openOrDownloadBook(context, subject.bookUrl, subject.title);
},
icon: const Icon(Icons.download, size: 18),
label: const Text('تحميل'),
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
);
}
}

class FavoritesTab extends StatefulWidget {
final List<Subject> subjects;
const FavoritesTab({super.key, required this.subjects});

@override
State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
@override
Widget build(BuildContext context) {
final favorites = widget.subjects.where((s) => s.isFavorite).toList();

return Scaffold(
appBar: AppBar(
title: const Text('الكتب المفضلة', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
centerTitle: true,
backgroundColor: const Color(0xFF00796B),
),
body: favorites.isEmpty
? const Center(child: Text('لا توجد كتب مضافة للمفضلة حتى الآن', style: TextStyle(color: Colors.grey, fontSize: 16)))
: ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: favorites.length,
itemBuilder: (context, index) {
final subject = favorites[index];
return Card(
child: ListTile(
leading: const Icon(Icons.book, color: Color(0xFF00796B)),
title: Text(subject.title, style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text('${subject.stageName} / ${subject.className}'),
trailing: IconButton(
icon: const Icon(Icons.delete_outline, color: Colors.red),
onPressed: () {
setState(() {
subject.isFavorite = false;
});
},
),
onTap: () {
openOrDownloadBook(context, subject.bookUrl, subject.title);
},
),
);
},
),
);
}
}

class BookSearchDelegate extends SearchDelegate<String> {
final List<Subject> allSubjects;
BookSearchDelegate({required this.allSubjects});

@override
String get searchFieldLabel => 'ابحث عن أي كتاب دراسي...';

@override
List<Widget> buildActions(BuildContext context) {
return [
IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
];
}

@override
Widget buildLeading(BuildContext context) {
return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));
}

@override
Widget buildResults(BuildContext context) => _buildSearchResults();

@override
Widget buildSuggestions(BuildContext context) => _buildSearchResults();

Widget _buildSearchResults() {
final filtered = allSubjects.where((s) => s.title.toLowerCase().contains(query.toLowerCase())).toList();

if (filtered.isEmpty) {
return const Center(child: Text('لم يتم العثور على أي كتاب مطابق', style: TextStyle(color: Colors.grey)));
}

return ListView.builder(
padding: const EdgeInsets.all(16),
itemCount: filtered.length,
itemBuilder: (context, index) {
final subject = filtered[index];
return Card(
child: ListTile(
leading: const Icon(Icons.menu_book, color: Color(0xFF00796B)),
title: Text(subject.title, style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text('${subject.stageName} - ${subject.className}'),
onTap: () {
openOrDownloadBook(context, subject.bookUrl, subject.title);
},
),
);
},
);
}
}
