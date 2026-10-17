import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

late SharedPreferences appPrefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appPrefs = await SharedPreferences.getInstance();
  final savedHistory = appPrefs.getString('quizHistory');
  if (savedHistory != null) {
    try {
      quizHistory
        ..clear()
        ..addAll((jsonDecode(savedHistory) as List).map((e) => QuizResult.fromJson(Map<String, dynamic>.from(e))));
    } catch (_) {
      quizHistory.clear();
    }
  }
  runApp(const IraqiLibraryApp());
}

const navy = Color(0xFF142D4E);
const blue = Color(0xFF2864E8);
const teal = Color(0xFF0C9B83);
const purple = Color(0xFF8655C8);
const canvas = Color(0xFFF4F7FC);

// نتائج الاختبارات تحفظ محلياً على Android والويب بواسطة shared_preferences.
final List<QuizResult> quizHistory = [];

Future<void> saveQuizHistory() async {
  await appPrefs.setString('quizHistory', jsonEncode(quizHistory.map((e) => e.toJson()).toList()));
}

const primaryBooksByGrade = <String, List<Map<String, String>>>{
  'الأول الابتدائي': [
    {
      'title': 'كتاب التربية الإسلامية',
      'subject': 'الإسلامية',
      'url': 'https://drive.google.com/file/d/1idf1IS_S_XcSXCoDFb59tpaH41hyYEzu/view',
    },
    {
      'title': 'كتاب القراءة',
      'subject': 'اللغة العربية',
      'url': 'https://drive.google.com/file/d/1vAgdbV5NNjyQ4k_LxzTiIHg7sVypX93Z/view',
    },
    {
      'title': 'كتاب اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/12cLRJZ0Re6aOrG_rM2JGFAiR1t_kvQIa/view',
    },
    {
      'title': 'نشاط اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1V0JkjgaYztH9LsEAKQR-BkUwpjig8xeV/view',
    },
    {
      'title': 'كتاب الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1KsxJxe0W5h-feD1jL0i9YVitoprbeRd1/view',
    },
    {
      'title': 'نشاط الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1DG7fL9MfuL5NqTDuG7hRa5aaD9vqmM79/view',
    },
    {
      'title': 'كتاب العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/11TqMbf2GqbldP8DwCiRV2R8lsSay89oF/view',
    },
    {
      'title': 'نشاط العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1QeJR7DsfMqkiyuI4fgW0m5CErHYIK0lu/view',
    },
    {
      'title': 'كتاب الأخلاقية',
      'subject': 'الأخلاقية',
      'url': 'https://drive.google.com/file/d/1PQFy1vS77opnyaDWLcBz4J2rtrqmK_sZ/view',
    },
  ],
  'الثاني الابتدائي': [
    {
      'title': 'كتاب التربية الإسلامية',
      'subject': 'الإسلامية',
      'url': 'https://drive.google.com/file/d/1sgXP7NNoAYvAvc6hj_PxNzA5U_-v_MPo/view',
    },
    {
      'title': 'كتاب القراءة',
      'subject': 'اللغة العربية',
      'url': 'https://drive.google.com/file/d/1OwLe8elhbqcr0Oe5t2Hf9mAvYfgON6w5/view',
    },
    {
      'title': 'كتاب اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1cKHbMM7vNc8eqcQ4J_GAG0lsva2Sp3hF/view',
    },
    {
      'title': 'نشاط اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1V1NhW8lQLtaAXzl-zpHWL6dU6aCcFRRn/view',
    },
    {
      'title': 'كتاب الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/13nk4HvTojF_MSSmsV_Wtp6wXoWx6wrUP/view',
    },
    {
      'title': 'نشاط الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1M7csrP8ESi_ejvEL_2WKBJLSL_VV6D2F/view',
    },
    {
      'title': 'كتاب العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1UkKWZ0aAwZyBHrfzc2C1ZWB5WvNn9l5b/view',
    },
    {
      'title': 'نشاط العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1etu-YJv82iZqH9_VOSK_UGVILHVOY6dc/view',
    },
    {
      'title': 'كتاب الأخلاقية',
      'subject': 'الأخلاقية',
      'url': 'https://drive.google.com/file/d/1X3nIzGQCUpeK5DQqRjoT_U97AiHTBlWH/view',
    },
  ],
  'الثالث الابتدائي': [
    {
      'title': 'كتاب التربية الإسلامية',
      'subject': 'الإسلامية',
      'url': 'https://drive.google.com/file/d/1GNfl_jfkIZTlCAzSJJlZdfzcXp9Yg8A0/view',
    },
    {
      'title': 'كتاب القراءة',
      'subject': 'اللغة العربية',
      'url': 'https://drive.google.com/file/d/1EujI_2O0LtoZgWVKbz4_n-CVlzSeVBuG/view',
    },
    {
      'title': 'كتاب اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/10c2x_pbyM1qUb4-2UnorIUoCiReHGpYz/view',
    },
    {
      'title': 'نشاط اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1FGACF7U-oqeEIfgqiphYsMdWbeTAFyj4/view',
    },
    {
      'title': 'كتاب الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1e7rcS2xAzfSc3PK_mx7IHRHiv94xwLmi/view',
    },
    {
      'title': 'نشاط الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1t88XP_kDtSrdPFv1gip4bJQfo2xsEgZP/view',
    },
    {
      'title': 'كتاب العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1f7RlugDalwJ3iQidd7B_bg-vpNR9cRcf/view',
    },
    {
      'title': 'نشاط العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1OCwai2pYlOg3-ujitXmNJ7LGg6jvJ4h8/view',
    },
  ],
  'الرابع الابتدائي': [
    {
      'title': 'كتاب التربية الإسلامية',
      'subject': 'الإسلامية',
      'url': 'https://drive.google.com/file/d/1qrQ0m3BpEpGpddG4Ga_oGxOBGbAVmdc1/view',
    },
    {
      'title': 'كتاب القراءة',
      'subject': 'اللغة العربية',
      'url': 'https://drive.google.com/file/d/1FwlJF6FlAQYfkeThkoKcExM-WAeK3XKI/view',
    },
    {
      'title': 'كتاب القواعد',
      'subject': 'القواعد',
      'url': 'https://drive.google.com/file/d/1ld5aGZnQLGsFoNOklylefc0CaD8ikZPY/view',
    },
    {
      'title': 'كتاب اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1od1MGHZJ_erJednreUzwC1U7YQSjuzBw/view',
    },
    {
      'title': 'نشاط اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1B6sT5nd6kj5ljdPF270igMhkrqyyvsqj/view',
    },
    {
      'title': 'كتاب الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1u0T7voKBEViq_lfBOzOABXXv-nH-UR8w/view',
    },
    {
      'title': 'نشاط الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1vuJbrL80ri-MLvkk7UXdLJuPbFKUxK3I/view',
    },
    {
      'title': 'كتاب العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1pB7l4fgD2tpDpWwSs1gfCz2kbOVjAru0/view',
    },
    {
      'title': 'نشاط العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/143YTfRRY0X6yNqf0BXs5CFjyeCus2EGT/view',
    },
    {
      'title': 'كتاب الاجتماعيات',
      'subject': 'الاجتماعيات',
      'url': 'https://drive.google.com/file/d/119FjK-goDmppik85_g7iUGZly2qySope/view',
    },
  ],
  'الخامس الابتدائي': [
    {
      'title': 'كتاب التربية الإسلامية',
      'subject': 'الإسلامية',
      'url': 'https://drive.google.com/file/d/1toPZxJtvEF22aO2CFY6eTIID_mOijBPJ/view',
    },
    {
      'title': 'كتاب القراءة',
      'subject': 'اللغة العربية',
      'url': 'https://drive.google.com/file/d/1WO4ZRerrs5DTOkhucLfmvSzDbJM-izCL/view',
    },
    {
      'title': 'كتاب القواعد',
      'subject': 'القواعد',
      'url': 'https://drive.google.com/file/d/1yd47rq8fgGsAYUfnsB6T2jfZ6PV-9YWP/view',
    },
    {
      'title': 'كتاب اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1WsOjod92DE7jEqGpvdrrekI_OPBne17_/view',
    },
    {
      'title': 'نشاط اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/19KG6V4waG0_wgwfA3BHTbNhHMrgCcwu9/view',
    },
    {
      'title': 'كتاب الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/19Vw-FeVe5UZfHufy8U9_ZeDrPJPBv6Sh/view',
    },
    {
      'title': 'نشاط الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/19jhpW5XjFVRi0xaSu2uKTMyL-zP5Yt62/view',
    },
    {
      'title': 'كتاب العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1SxdVpZk9brkv4YRpbX_wIe1c3yrIzfkY/view',
    },
    {
      'title': 'نشاط العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1OPd-LH8vclgd4KKBGsf24X_gYB77jdgt/view',
    },
    {
      'title': 'كتاب الاجتماعيات',
      'subject': 'الاجتماعيات',
      'url': 'https://drive.google.com/file/d/1i5RbK2zY4AfOFB1RnWkBCEYrqhSZow8s/view',
    },
  ],
  'السادس الابتدائي': [
    {
      'title': 'كتاب التربية الإسلامية',
      'subject': 'الإسلامية',
      'url': 'https://drive.google.com/file/d/1Lx7OGHY5S8bqglDX_5KmgmyxRbfccpVB/view',
    },
    {
      'title': 'كتاب القراءة',
      'subject': 'اللغة العربية',
      'url': 'https://drive.google.com/file/d/1955uM36MDE54JuC5bAvheYLocrN6pLZ_/view',
    },
    {
      'title': 'كتاب القواعد',
      'subject': 'القواعد',
      'url': 'https://drive.google.com/file/d/1lEtZ_U_DGHadnrqHTKMe945_toxRuC0r/view',
    },
    {
      'title': 'كتاب اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/1oLRTuvvg2TWLH-tx3ynPai7bU98xl3Jf/view',
    },
    {
      'title': 'نشاط اللغة الإنكليزية',
      'subject': 'اللغة الإنكليزية',
      'url': 'https://drive.google.com/file/d/12KodkqqgIxl6C0iqV7Xj6nX_RMNY12V-/view',
    },
    {
      'title': 'كتاب الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1eruXvQZRELfJn_cab2VmYYUhZ2PDq_tK/view',
    },
    {
      'title': 'نشاط الرياضيات',
      'subject': 'الرياضيات',
      'url': 'https://drive.google.com/file/d/1WjTTipG5RW52qUZDhjmXj7uN4B0YPr1C/view',
    },
    {
      'title': 'كتاب العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1hHSjYlxNHCkx8_D9ZeYtBxW7szZZ0Rdu/view',
    },
    {
      'title': 'نشاط العلوم',
      'subject': 'العلوم',
      'url': 'https://drive.google.com/file/d/1QiJXj0Aa0fEtp2_kTkmKYQu09yIL-Ust/view',
    },
    {
      'title': 'كتاب الاجتماعيات',
      'subject': 'الاجتماعيات',
      'url': 'https://drive.google.com/file/d/18niTWYBMKB6z5TTTwa_1J6Jn6-oE2amK/view',
    },
  ],
};

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
      'الإسلامية', 'اللغة العربية', 'اللغة الإنكليزية', 'الرياضيات', 'العلوم',
    ];
    if (number <= 2) result.add('الأخلاقية');
    if (number >= 4) {
      result.add('القواعد');
      result.add('الاجتماعيات');
    }
    return result;
  }
  if (grade.contains('المتوسط')) {
    final result = <String>[
      'الإسلامية', 'اللغة العربية', 'اللغة الإنكليزية', 'الرياضيات',
      'العلوم', 'الاجتماعيات',
    ];
    if (grade == 'الأول المتوسط' || grade == 'الثاني المتوسط') {
      result.add('الحاسوب');
    }
    return result;
  }
  if (grade.contains('العلمي')) {
    final result = <String>[
      'الإسلامية', 'اللغة العربية', 'اللغة الإنكليزية', 'الرياضيات',
      'الفيزياء', 'الكيمياء', 'الأحياء',
    ];
    if (grade == 'الرابع العلمي' || grade == 'الخامس العلمي') {
      result.add('الحاسوب');
    }
    return result;
  }
  return [
    'الإسلامية', 'اللغة العربية', 'اللغة الإنكليزية', 'الرياضيات',
    'التاريخ', 'الجغرافية', 'الاقتصاد',
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
    case 'القواعد':
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
    case 'الأخلاقية':
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
    final supplied = primaryBooksByGrade[grade];
    if (supplied != null) {
      books.addAll(supplied.map((item) => SchoolBook(
            title: item['title']!,
            subject: item['subject']!,
            grade: grade,
            url: item['url']!,
          )));
      // Add clearly marked placeholders only for subjects that do not yet have a supplied link.
      for (final subject in gradeSubjectsFor(grade)) {
        if (!supplied.any((item) => item['subject'] == subject)) {
          books.add(SchoolBook(
            title: 'كتاب $subject (الرابط غير متوفر حالياً)',
            subject: subject,
            grade: grade,
            url: '',
          ));
        }
      }
      continue;
    }

    for (final subject in gradeSubjectsFor(grade)) {
      books.add(SchoolBook(
        title: 'كتاب $subject',
        subject: subject,
        grade: grade,
        url: '',
      ));
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
  bool dark = appPrefs.getBool('darkMode') ?? false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مكتبة المناهج العراقية',
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: canvas,
          foregroundColor: navy,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 18,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Color(0xFFE7EDF6)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF8793A5)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: Color(0xFFE4EAF3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: blue, width: 1.5),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            side: const BorderSide(color: Color(0xFFDCE5F2)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 72,
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFE3EBFF),
          surfaceTintColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1422),
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
          surface: const Color(0xFF151F30),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D1422),
          foregroundColor: Color(0xFFF3F6FC),
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 18,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF151F30),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Color(0xFF26364B)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF151F30),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9BA8BC)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: Color(0xFF29374B)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(color: Color(0xFF6B8FF5), width: 1.5),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            side: const BorderSide(color: Color(0xFF33435A)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 72,
          backgroundColor: const Color(0xFF111B2B),
          indicatorColor: const Color(0xFF253D68),
          surfaceTintColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      home: LibraryHome(
        dark: dark,
        onDarkChanged: (value) {
          setState(() => dark = value);
          appPrefs.setBool('darkMode', value);
        },
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
  bool dataLoaded = false;
  final noteController = TextEditingController();
  final searchController = TextEditingController();

  String selectedGrade = grades.first;
  String search = '';
  int page = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    favorites
      ..clear()
      ..addAll(appPrefs.getStringList('favorites') ?? const <String>[]);
    notes
      ..clear()
      ..addAll(appPrefs.getStringList('notes') ?? const <String>[]);
    final savedGrade = appPrefs.getString('selectedGrade');
    if (savedGrade != null && grades.contains(savedGrade)) selectedGrade = savedGrade;
    if (mounted) setState(() => dataLoaded = true);
  }

  Future<void> _saveFavorites() => appPrefs.setStringList('favorites', favorites.toList());
  Future<void> _saveNotes() => appPrefs.setStringList('notes', notes);

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
          toolbarHeight: 78,
          title: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [blue, Color(0xFF6B8FF5)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: blue.withOpacity(0.22), blurRadius: 16, offset: const Offset(0, 6)),
                  ],
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
        const SizedBox(height: 16),
        _progressSummaryCard(),
        const SizedBox(height: 18),
        const SectionHeading(
          title: 'أدواتك الدراسية',
          subtitle: 'اختصارات تساعدك على تنظيم الدراسة والمراجعة',
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: wide ? 2.05 : 1.55,
          children: [
            _featureShortcut(
              icon: Icons.calendar_month_rounded,
              title: 'الجدول الدراسي',
              color: teal,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudyPlannerScreen())),
            ),
            _featureShortcut(
              icon: Icons.psychology_alt_rounded,
              title: 'المساعد الدراسي',
              color: purple,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudyAssistantScreen())),
            ),
            _featureShortcut(
              icon: Icons.insights_rounded,
              title: 'تقدم الطالب',
              color: blue,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressScreen())),
            ),
            _featureShortcut(
              icon: Icons.offline_pin_rounded,
              title: 'التنزيلات',
              color: const Color(0xFFB7791F),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OfflineCenterScreen(books: books))),
            ),
          ],
        ),
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
              mainAxisExtent: 178,
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

  Widget _progressSummaryCard() {
    final count = quizHistory.length;
    final average = count == 0
        ? 0
        : (quizHistory.map((r) => r.percent).reduce((a, b) => a + b) / count).round();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF26364B)
              : const Color(0xFFE7EDF6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(widget.dark ? 0.08 : 0.035),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [blue, Color(0xFF7094F8)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.trending_up_rounded, color: Colors.white, size: 27),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'رحلتك الدراسية',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'اختبارات منجزة: $count',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.insights_rounded, size: 14, color: teal),
                      const SizedBox(width: 4),
                      Text(
                        'متوسط الدرجات $average%',
                        style: const TextStyle(color: teal, fontSize: 11, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            IconButton.filledTonal(
              tooltip: 'عرض التقدم',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProgressScreen()),
              ),
              icon: const Icon(Icons.arrow_back_rounded, size: 19),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureShortcut({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [color.withOpacity(.18), color.withOpacity(.07)],
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: color, size: 21),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, height: 1.25),
                  ),
                ),
                const SizedBox(width: 2),
                Icon(Icons.chevron_left_rounded, size: 17, color: color.withOpacity(.8)),
              ],
            ),
          ),
        ),
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
                    appPrefs.setString('selectedGrade', value);
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF132D50), Color(0xFF2458B9), Color(0xFF2864E8)],
          stops: [0, .52, 1],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: blue.withOpacity(.22), blurRadius: 24, offset: const Offset(0, 10)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Icon(Icons.auto_stories_rounded, size: 140, color: Colors.white.withOpacity(.07)),
          ),
          Positioned(
            left: 42,
            bottom: 5,
            child: Icon(Icons.auto_awesome_rounded, size: 34, color: Colors.white.withOpacity(.12)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(color: Color(0xFF65E0BF), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.13),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(.10)),
                    ),
                    child: const Text(
                      'مساحة تعلّمك',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'كل كتبك الدراسية،\nفي مكان واحد.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  height: 1.23,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'نظّم دراستك وخلّ وصولك للمعلومة أسهل.',
                style: TextStyle(color: Color(0xFFDCE7FF), fontSize: 12, height: 1.5),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _heroMetric(Icons.menu_book_rounded, '${books.length} كتاب'),
                  _heroMetric(Icons.favorite_rounded, '${favorites.length} مفضلة'),
                ],
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: navy,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  minimumSize: const Size(0, 42),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  setState(() {
                    page = 0;
                    search = '';
                    searchController.clear();
                  });
                },
                icon: const Icon(Icons.menu_book_rounded, size: 18),
                label: const Text('تصفّح الكتب', style: TextStyle(fontWeight: FontWeight.w900)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroMetric(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
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
              mainAxisExtent: 178,
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
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(
          title: 'مركز الاختبارات',
          subtitle: 'اختر الصف والمادة لبدء اختبار من 100 سؤال مع التصحيح التلقائي',
        ),
        const SizedBox(height: 18),
        DropdownButtonFormField<String>(
          value: selectedGrade,
          decoration: const InputDecoration(labelText: 'الصف الدراسي'),
          items: grades.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
          onChanged: (value) {
            if (value != null) { setState(() => selectedGrade = value); appPrefs.setString('selectedGrade', value); }
          },
        ),
        const SizedBox(height: 14),
        const Text('مواد هذا الصف', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        ...gradeSubjectsFor(selectedGrade).map((subject) => Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: subjectColor(subject).withOpacity(.12),
              child: Icon(subjectIcon(subject), color: subjectColor(subject)),
            ),
            title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('100 سؤال اختيار من متعدد'),
            trailing: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => QuizScreen(grade: selectedGrade, subject: subject),
              ));
            },
          ),
        )),
        const SizedBox(height: 8),
        const Text(
          'تنبيه: بنك الأسئلة الحالي تجريبي/عام. لمطابقة الأسئلة حرفياً مع طبعات المنهج العراقي، أرسل كتب المواد بصيغة PDF ليتم إعداد بنك موثّق لكل صف.',
          style: TextStyle(fontSize: 12, height: 1.6, color: Colors.grey),
        ),
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
            _saveNotes();
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
                    _saveNotes();
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
            subtitle: Text('البيانات تحفظ محلياً على الجهاز أو المتصفح ولا تُرسل إلى خادم.'),
          ),
        ),
        Card(child: ListTile(leading: const Icon(Icons.delete_sweep_outlined), title: const Text('مسح بيانات التطبيق المحفوظة'), subtitle: const Text('يحذف المفضلة والملاحظات والنتائج والمهام وسجل المساعد.'), onTap: () async { final ok = await showDialog<bool>(context: context, builder: (c) => AlertDialog(title: const Text('مسح البيانات؟'), content: const Text('لا يمكن التراجع عن هذه العملية.'), actions: [TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('إلغاء')), FilledButton(onPressed: () => Navigator.pop(c, true), child: const Text('مسح'))])); if (ok == true) { await appPrefs.clear(); quizHistory.clear(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم مسح البيانات المحلية. أعد تحميل التطبيق لتطبيق الإعدادات.'))); } })),
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
    _saveFavorites();
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
      launchUrl(Uri.parse(downloadUrl), mode: LaunchMode.externalApplication);
    } else {
      launchUrl(Uri.parse(book.url), mode: LaunchMode.externalApplication);
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
                                launchUrl(Uri.parse(book.url), mode: LaunchMode.externalApplication);
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
    final hasLink = book.url.isNotEmpty;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(11, 10, 11, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [color.withOpacity(.20), color.withOpacity(.07)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(subjectIcon(book.subject), color: color, size: 23),
                  ),
                  const Spacer(),
                  IconButton(
                    constraints: const BoxConstraints.tightFor(width: 34, height: 34),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    onPressed: onFavorite,
                    tooltip: favorite ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة',
                    icon: Icon(
                      favorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: favorite ? Colors.redAccent : (isDark ? Colors.white54 : const Color(0xFF9AA6B7)),
                      size: 19,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, height: 1.25),
              ),
              const SizedBox(height: 4),
              Text(
                book.grade,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                    decoration: BoxDecoration(
                      color: (hasLink ? teal : Colors.blueGrey).withOpacity(.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(hasLink ? Icons.link_rounded : Icons.schedule_rounded,
                            size: 12, color: hasLink ? teal : Colors.blueGrey),
                        const SizedBox(width: 3),
                        Text(
                          hasLink ? 'متاح' : 'قريباً',
                          style: TextStyle(
                            color: hasLink ? teal : Colors.blueGrey,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'تحميل الكتاب',
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints.tightFor(width: 34, height: 30),
                    padding: EdgeInsets.zero,
                    onPressed: onDownload,
                    icon: Icon(Icons.download_rounded, size: 19, color: color),
                  ),
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 31),
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      backgroundColor: color.withOpacity(.10),
                      foregroundColor: color,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('عرض', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
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
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 39,
          margin: const EdgeInsets.only(top: 2, left: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [blue, teal], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -.25,
                  color: dark ? const Color(0xFFF2F5FB) : navy,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.45,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
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
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [blue.withOpacity(.15), teal.withOpacity(.07)],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: blue.withOpacity(.10)),
            ),
            child: Icon(icon, size: 39, color: blue),
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


class QuizResult {
  final String grade;
  final String subject;
  final int score;
  final int total;
  final DateTime date;
  const QuizResult({required this.grade, required this.subject, required this.score, required this.total, required this.date});
  int get percent => total == 0 ? 0 : (score / total * 100).round();
  Map<String, dynamic> toJson() => {'grade': grade, 'subject': subject, 'score': score, 'total': total, 'date': date.toIso8601String()};
  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
    grade: json['grade'] as String? ?? grades.first,
    subject: json['subject'] as String? ?? 'مادة',
    score: (json['score'] as num?)?.toInt() ?? 0,
    total: (json['total'] as num?)?.toInt() ?? 0,
    date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
  );
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final results = quizHistory.reversed.toList();
    final average = results.isEmpty ? 0 : (results.map((e) => e.percent).reduce((a, b) => a + b) / results.length).round();
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(title: const Text('تقدم الطالب')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
          Expanded(child: _progressMetric('الاختبارات', '${results.length}', Icons.quiz_rounded, blue)),
          Expanded(child: _progressMetric('المتوسط', '$average%', Icons.insights_rounded, teal)),
          Expanded(child: _progressMetric('الأسئلة المجابة', '${results.fold<int>(0, (sum, e) => sum + e.total)}', Icons.check_circle_rounded, purple)),
        ]))),
        const SizedBox(height: 18),
        const SectionHeading(title: 'سجل الاختبارات', subtitle: 'النتائج المحفوظة على هذا الجهاز أو المتصفح'),
        const SizedBox(height: 12),
        if (results.isEmpty)
          const EmptyState(icon: Icons.auto_graph_rounded, title: 'لا توجد نتائج بعد', subtitle: 'أكمل اختباراً من مركز الاختبارات حتى يظهر تقدمك هنا.')
        else ...results.map((r) => Card(margin: const EdgeInsets.only(bottom: 9), child: ListTile(
          leading: CircleAvatar(backgroundColor: (r.percent >= 50 ? teal : Colors.orange).withOpacity(.12), child: Text('${r.percent}%', style: TextStyle(fontSize: 11, color: r.percent >= 50 ? teal : Colors.orange, fontWeight: FontWeight.bold))),
          title: Text('${r.subject} — ${r.grade}', style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('الدرجة ${r.score} من ${r.total}  •  ${r.date.year}/${r.date.month}/${r.date.day}'),
          trailing: const Icon(Icons.chevron_left_rounded),
        ))),
        const SizedBox(height: 10),
        const Text('تُحفظ النتائج محلياً على هذا الجهاز أو المتصفح. مسح بيانات التطبيق أو المتصفح قد يحذفها.', style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.6)),
      ]),
    ));
  }
  Widget _progressMetric(String label, String value, IconData icon, Color color) => Column(children: [Icon(icon, color: color, size: 24), const SizedBox(height: 7), Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center)]);
}

class StudyTask {
  final String title;
  final String grade;
  final String subject;
  final DateTime due;
  bool done;
  StudyTask({required this.title, required this.grade, required this.subject, required this.due, this.done = false});
  Map<String, dynamic> toJson() => {'title': title, 'grade': grade, 'subject': subject, 'due': due.toIso8601String(), 'done': done};
  factory StudyTask.fromJson(Map<String, dynamic> j) => StudyTask(title: j['title'] as String? ?? '', grade: j['grade'] as String? ?? grades.first, subject: j['subject'] as String? ?? 'الإسلامية', due: DateTime.tryParse(j['due'] as String? ?? '') ?? DateTime.now(), done: j['done'] as bool? ?? false);
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});
  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}
class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  final tasks = <StudyTask>[];
  final titleController = TextEditingController();
  String grade = grades.first;
  String subject = 'الإسلامية';
  DateTime due = DateTime.now().add(const Duration(days: 1));
  @override
  void initState() { super.initState(); _loadTasks(); }
  Future<void> _loadTasks() async {
    try { final raw = appPrefs.getString('studyTasks'); if (raw != null) { tasks..clear()..addAll((jsonDecode(raw) as List).map((e) => StudyTask.fromJson(Map<String, dynamic>.from(e)))); if (mounted) setState(() {}); } } catch (_) {}
  }
  Future<void> _saveTasks() => appPrefs.setString('studyTasks', jsonEncode(tasks.map((e) => e.toJson()).toList()));
  @override
  void dispose() { titleController.dispose(); super.dispose(); }
  Future<void> addTask() async {
    final title = titleController.text.trim();
    if (title.isEmpty) return;
    setState(() { tasks.add(StudyTask(title: title, grade: grade, subject: subject, due: due)); titleController.clear(); });
    await _saveTasks();
    FocusScope.of(context).unfocus();
  }
  @override
  Widget build(BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: Scaffold(
    appBar: AppBar(title: const Text('الجدول الدراسي')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const SectionHeading(title: 'خطتك اليومية', subtitle: 'أضف واجباتك ومواعيد المراجعة'),
      const SizedBox(height: 16),
      TextField(controller: titleController, decoration: const InputDecoration(labelText: 'المهمة الدراسية', hintText: 'مثلاً: مراجعة الفصل الأول')),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: grade, decoration: const InputDecoration(labelText: 'الصف الدراسي'), items: grades.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(), onChanged: (v) { if (v != null) setState(() { grade = v; final valid = gradeSubjectsFor(grade); if (!valid.contains(subject)) subject = valid.first; }); }),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: gradeSubjectsFor(grade).contains(subject) ? subject : gradeSubjectsFor(grade).first, decoration: const InputDecoration(labelText: 'المادة'), items: gradeSubjectsFor(grade).map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) { if (v != null) setState(() => subject = v); }),
      const SizedBox(height: 12),
      OutlinedButton.icon(onPressed: () async { final d = await showDatePicker(context: context, initialDate: due, firstDate: DateTime.now().subtract(const Duration(days: 365)), lastDate: DateTime.now().add(const Duration(days: 3650))); if (d != null) setState(() => due = d); }, icon: const Icon(Icons.calendar_month_rounded), label: Text('موعد المهمة: ${due.year}/${due.month}/${due.day}')),
      const SizedBox(height: 10),
      FilledButton.icon(onPressed: addTask, icon: const Icon(Icons.add_rounded), label: const Text('إضافة إلى الجدول')),
      const SizedBox(height: 22),
      const SectionHeading(title: 'المهام', subtitle: 'علّم المهمة عند إنجازها'),
      const SizedBox(height: 10),
      if (tasks.any((t) => !t.done && !t.due.isAfter(DateTime.now()))) Card(color: Colors.orange.withOpacity(.10), child: const ListTile(leading: Icon(Icons.notifications_active_rounded, color: Colors.deepOrange), title: Text('لديك مهمة مستحقة'), subtitle: Text('راجع المهام أدناه. يظهر هذا التنبيه عند فتح الجدول الدراسي.'))),
      if (tasks.isEmpty) const EmptyState(icon: Icons.event_note_rounded, title: 'جدولك فارغ', subtitle: 'أضف أول مهمة دراسية للبدء.'),
      ...tasks.asMap().entries.map((e) => Card(margin: const EdgeInsets.only(bottom: 8), child: CheckboxListTile(value: e.value.done, onChanged: (v) { setState(() => e.value.done = v ?? false); _saveTasks(); }, title: Text(e.value.title, style: TextStyle(decoration: e.value.done ? TextDecoration.lineThrough : null, fontWeight: FontWeight.bold)), subtitle: Text('${e.value.grade} • ${e.value.subject} • ${e.value.due.year}/${e.value.due.month}/${e.value.due.day}'), secondary: IconButton(icon: const Icon(Icons.delete_outline_rounded), onPressed: () { setState(() => tasks.removeAt(e.key)); _saveTasks(); }), controlAffinity: ListTileControlAffinity.leading))),
      const SizedBox(height: 8),
      const Text('تُحفظ المهام محلياً على هذا الجهاز أو المتصفح. التذكيرات تظهر داخل التطبيق عند فتح الجدول؛ إشعارات النظام تحتاج إعداداً إضافياً خاصاً بكل منصة.', style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.6)),
    ]),
  ));
}

class StudyAssistantScreen extends StatefulWidget {
  const StudyAssistantScreen({super.key});
  @override
  State<StudyAssistantScreen> createState() => _StudyAssistantScreenState();
}
class _StudyAssistantScreenState extends State<StudyAssistantScreen> {
  final controller = TextEditingController();
  final messages = <Map<String, String>>[
    {'from': 'assistant', 'text': 'أهلاً بك! أستطيع مساعدتك بنصائح المذاكرة، وتنظيم وقتك، واقتراح طريقة لفهم الدرس. اكتب سؤالك أدناه. هذه نسخة محلية تعمل دون إنترنت وليست نموذج ذكاء اصطناعي سحابياً.'}
  ];
  @override
  void initState() { super.initState(); final saved = appPrefs.getString('assistantMessages'); if (saved != null) { try { messages..clear()..addAll((jsonDecode(saved) as List).map((e) => Map<String, String>.from(e))); } catch (_) {} } }
  Future<void> _saveMessages() => appPrefs.setString('assistantMessages', jsonEncode(messages));
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  String answerFor(String q) {
    final t = q.toLowerCase();
    if (t.contains('رياضيات') || t.contains('مسألة') || t.contains('معادلة')) return 'في الرياضيات: اكتب المعطيات أولاً، ثم حدّد المطلوب، واختر القانون المناسب، وحل خطوة بخطوة. أرسل نص المسألة كاملاً لأساعدك في ترتيب خطوات الحل.';
    if (t.contains('إنكليزي') || t.contains('انكليزي') || t.contains('english')) return 'لتطوير الإنكليزية: احفظ مفردات قليلة يومياً ضمن جمل، وراجع القواعد بالأمثلة، ثم حل أسئلة قصيرة مع التحقق من الإجابات.';
    if (t.contains('حفظ') || t.contains('أحفظ')) return 'جرّب الاسترجاع النشط: اقرأ فقرة قصيرة، أغلق الكتاب، اشرحها من ذاكرتك، ثم راجع ما نسيته. كرر المراجعة بعد يوم ثم بعد عدة أيام.';
    if (t.contains('جدول') || t.contains('وقت') || t.contains('نظم')) return 'قسّم وقتك إلى جلسات 25 دقيقة وبينها استراحة 5 دقائق. ابدأ بالمادة الأصعب، وحدد هدفاً صغيراً واضحاً لكل جلسة.';
    if (t.contains('امتحان') || t.contains('اختبار')) return 'للاستعداد للامتحان: راجع أهداف الفصل، حل أسئلة دون النظر إلى الكتاب، سجّل أخطاءك، ثم أعد حل الأسئلة التي أخطأت فيها.';
    if (t.contains('عربي') || t.contains('نحو')) return 'في اللغة العربية، حدّد نوع الكلمة وموقعها في الجملة، ثم اربط القاعدة بمثال صحيح. دوّن مثالين من الكتاب لكل قاعدة.';
    return 'أستطيع تقديم إرشادات دراسية عامة حالياً. اكتب المادة أو موضوع الدرس بصورة أوضح، مثل: طريقة مراجعة الفيزياء أو تنظيم وقت الامتحانات. للإجابات العلمية الدقيقة ينبغي الرجوع إلى نص الكتاب المعتمد.';
  }
  void send() {
    final q = controller.text.trim(); if (q.isEmpty) return;
    setState(() { messages.add({'from': 'user', 'text': q}); messages.add({'from': 'assistant', 'text': answerFor(q)}); controller.clear(); }); _saveMessages();
  }
  @override
  Widget build(BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: Scaffold(
    appBar: AppBar(title: const Text('المساعد الدراسي')),
    body: Column(children: [
      Expanded(child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: messages.length, itemBuilder: (context, i) { final m = messages[i]; final user = m['from'] == 'user'; return Align(alignment: user ? Alignment.centerLeft : Alignment.centerRight, child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(13), constraints: const BoxConstraints(maxWidth: 500), decoration: BoxDecoration(color: user ? blue.withOpacity(.12) : Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)), child: Text(m['text'] ?? '', style: const TextStyle(height: 1.5)))); })),
      SafeArea(top: false, child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [Expanded(child: TextField(controller: controller, minLines: 1, maxLines: 4, onSubmitted: (_) => send(), decoration: const InputDecoration(hintText: 'اكتب سؤالك الدراسي...'))), const SizedBox(width: 8), IconButton.filled(onPressed: send, icon: const Icon(Icons.send_rounded))]))),
    ]),
  ));
}

class OfflineCenterScreen extends StatelessWidget {
  final List<SchoolBook> books;
  const OfflineCenterScreen({super.key, required this.books});
  @override
  Widget build(BuildContext context) {
    final available = books.where((b) => b.url.isNotEmpty).toList();
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(title: const Text('التنزيلات والعمل دون إنترنت')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [Icon(Icons.offline_pin_rounded, color: teal, size: 28), SizedBox(width: 9), Expanded(child: Text('مركز الكتب المتاحة للتنزيل', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)))]),
          const SizedBox(height: 10),
          const Text('يمكن فتح رابط التنزيل وحفظ ملف PDF على جهازك، ثم قراءته من تطبيق الملفات دون إنترنت. لا تظهر هنا إلا الكتب التي أُضيفت لها روابط فعلية؛ الرابط التجريبي الحالي لكتاب واحد فقط، وتحتاج بقية الكتب إلى روابط PDF رسمية.', style: TextStyle(height: 1.6)),
        ]))),
        const SizedBox(height: 18),
        if (available.isEmpty) const EmptyState(icon: Icons.cloud_off_rounded, title: 'لا توجد روابط تنزيل مضافة', subtitle: 'أضف روابط الكتب الرسمية حتى تظهر هنا.'),
        ...available.map((b) => Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(leading: const Icon(Icons.picture_as_pdf_rounded, color: blue), title: Text('${b.title} — ${b.grade}'), subtitle: Text(b.subject), trailing: IconButton(tooltip: 'فتح رابط الكتاب', icon: const Icon(Icons.download_rounded), onPressed: () async { final id = RegExp(r'/d/([^/]+)').firstMatch(b.url)?.group(1); final url = id == null ? b.url : 'https://drive.google.com/uc?export=download&id=$id'; await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication); })))) ,
      ]),
    ));
  }
}

class QuizQuestion {
  final String text;
  final List<String> choices;
  final int answer;
  const QuizQuestion(this.text, this.choices, this.answer);
}

// A starter bank of general practice questions. Official textbook alignment
// requires importing the relevant Iraqi curriculum books.
List<QuizQuestion> makeQuizQuestions(String grade, String subject) {
  final bank = <QuizQuestion>[];
  if (subject == 'الرياضيات') {
    for (var i = 1; i <= 100; i++) {
      final a = (i * 7) % 47 + 3;
      final b = (i * 11) % 29 + 2;
      final op = i % 4;
      late String q;
      late int ans;
      if (op == 0) { q = 'ما ناتج $a + $b ؟'; ans = a + b; }
      else if (op == 1) { final hi = a + b; q = 'ما ناتج $hi - $a ؟'; ans = b; }
      else if (op == 2) { q = 'ما ناتج $a × ${i % 9 + 2} ؟'; ans = a * (i % 9 + 2); }
      else { final divisor = i % 8 + 2; final value = divisor * (i % 12 + 2); q = 'ما ناتج $value ÷ $divisor ؟'; ans = value ~/ divisor; }
      final opts = <int>{ans, ans + 1, ans - 1, ans + 3}.toList();
      while (opts.length < 4) { opts.add(ans + opts.length + 2); }
      opts.shuffle();
      bank.add(QuizQuestion(q, opts.map((e) => '$e').toList(), opts.indexOf(ans)));
    }
    return bank;
  }
  final pools = <String, List<List<String>>>{
    'الإسلامية': [
      ['كم عدد أركان الإسلام؟','خمسة','ثلاثة','ستة','أربعة'],
      ['ما اسم كتاب المسلمين المقدس؟','القرآن الكريم','التوراة','الإنجيل','الزبور'],
      ['كم عدد الصلوات المفروضة يومياً؟','خمس صلوات','ثلاث صلوات','أربع صلوات','ست صلوات'],
      ['في أي شهر يصوم المسلمون؟','رمضان','شعبان','محرم','شوال'],
      ['ما قبلة المسلمين في الصلاة؟','الكعبة المشرفة','المسجد الأقصى','المسجد النبوي','جبل عرفات'],
    ],
    'اللغة العربية': [
      ['أيّ الكلمات الآتية اسم؟','مدرسة','يكتب','من','إلى'],
      ['ما ضد كلمة «الصدق»؟','الكذب','الأمانة','الإخلاص','الوفاء'],
      ['ما جمع كلمة «كتاب»؟','كتب','كاتب','مكتبة','كتابة'],
      ['أيّ مما يأتي حرف جر؟','من','كتب','هذا','هو'],
      ['ما نوع الجملة «أشرقت الشمس»؟','فعلية','اسمية','استفهامية','نداء'],
    ],
    'اللغة الإنكليزية': [
      ['What is the plural of “book”?','books','bookes','bookies','book'],
      ['Choose the correct meaning of “apple”.','تفاحة','مدرسة','قلم','نافذة'],
      ['What is the opposite of “big”?','small','tall','long','wide'],
      ['Choose the correct pronoun: ___ am a student.','I','He','They','She'],
      ['Which one is a colour?','green','table','school','water'],
    ],
    'العلوم': [
      ['ما الغاز الذي يحتاجه الإنسان للتنفس؟','الأوكسجين','النيتروجين','الهيدروجين','الهيليوم'],
      ['ما مصدر الضوء والحرارة للأرض؟','الشمس','القمر','المريخ','النجوم البعيدة'],
      ['أيّ جزء من النبات يمتص الماء غالباً؟','الجذور','الأزهار','الثمار','الأوراق فقط'],
      ['في أي حالة تكون للمادة شكل وحجم ثابتان؟','الصلبة','السائلة','الغازية','البلازما فقط'],
      ['ما العضو الذي يضخ الدم في الجسم؟','القلب','الرئة','المعدة','الكبد'],
    ],
    'الاجتماعيات': [
      ['ما عاصمة العراق؟','بغداد','البصرة','الموصل','أربيل'],
      ['أي نهرين يرتبط اسماهما بالعراق؟','دجلة والفرات','النيل والأمازون','الدانوب والراين','الغانج والسند'],
      ['في أي قارة يقع العراق؟','آسيا','أفريقيا','أوروبا','أستراليا'],
      ['ما الاتجاه المقابل للشمال؟','الجنوب','الشرق','الغرب','الشمال الشرقي'],
      ['ما الخريطة؟','تمثيل مصغر لسطح الأرض أو جزء منه','صورة لكوكب فقط','جدول حسابي','نوع من الصخور'],
    ],
    'الحاسوب': [
      ['أي جهاز يُستخدم لإدخال النصوص؟','لوحة المفاتيح','الشاشة','السماعات','الطابعة'],
      ['ما وظيفة الفأرة؟','تحريك المؤشر والاختيار','طباعة الأوراق','عرض الصوت فقط','تخزين الكهرباء'],
      ['أيّ مما يأتي جهاز إخراج؟','الشاشة','لوحة المفاتيح','الماسح الضوئي','الفأرة'],
      ['ماذا تعني CPU غالباً؟','وحدة المعالجة المركزية','وحدة الطباعة','ذاكرة خارجية','كابل الشبكة'],
      ['أي برنامج يُستخدم لتصفح المواقع؟','متصفح الإنترنت','آلة حاسبة فقط','محرر صور فقط','مشغل موسيقى فقط'],
    ],
    'الفيزياء': [
      ['ما وحدة قياس القوة في النظام الدولي؟','نيوتن','جول','واط','أمبير'],
      ['ما العلاقة العامة للسرعة؟','المسافة ÷ الزمن','الزمن ÷ المسافة','الكتلة × الحجم','القوة ÷ الزمن'],
      ['أي أداة تقيس درجة الحرارة؟','مقياس الحرارة','الميزان','الفولتميتر','المسطرة'],
      ['ما وحدة قياس التيار الكهربائي؟','أمبير','فولت','أوم','واط'],
      ['ماذا يحدث عادةً لحجم معظم المواد عند تسخينها؟','يتمدد','ينعدم','يتحول دائماً إلى صلب','لا يتغير مطلقاً'],
    ],
    'الكيمياء': [
      ['ما الرمز الكيميائي للأوكسجين؟','O','H','C','N'],
      ['ما الصيغة الكيميائية للماء؟','H₂O','CO₂','NaCl','O₂'],
      ['ما الجسيم ذو الشحنة السالبة؟','الإلكترون','البروتون','النيوترون','النواة'],
      ['ما الرقم الهيدروجيني للمحلول المتعادل تقريباً؟','7','1','3','14'],
      ['أيّ مما يأتي عنصر كيميائي؟','الحديد','الماء المالح','الهواء','السكر المذاب'],
    ],
    'الأحياء': [
      ['ما الوحدة الأساسية لبناء الكائن الحي؟','الخلية','النسيج','العضو','الجهاز'],
      ['أي عضية تقوم بالبناء الضوئي في النبات؟','البلاستيدات الخضراء','الميتوكوندريا','النواة فقط','الريبوسوم'],
      ['ما المادة الوراثية الأساسية؟','DNA','النشا','الماء','الهيموغلوبين'],
      ['أي جهاز مسؤول عن نقل الدم؟','الدوراني','الهضمي','الهيكلي','الإخراجي فقط'],
      ['ما الكائن الذي يصنع غذاءه غالباً بالبناء الضوئي؟','النبات الأخضر','الإنسان','الفطر','الحيوان'],
    ],
    'التاريخ': [
      ['ما المصدر الذي يعتمد عليه المؤرخ لدراسة الماضي؟','الوثائق والآثار','التوقعات فقط','الخيال وحده','الطقس اليومي'],
      ['ما المقصود بالتسلسل الزمني؟','ترتيب الأحداث حسب زمن وقوعها','ترتيب المدن أبجدياً','قياس المسافات','رسم التضاريس'],
      ['أيّ مما يأتي مثال على مصدر تاريخي مادي؟','قطعة أثرية','رأي غير موثق','توقع مستقبلي','حالة الطقس'],
      ['لماذا تُدرس الأحداث التاريخية؟','لفهم الماضي والاستفادة من تجاربه','لمعرفة الطقس فقط','لقياس سرعة الضوء','لتحديد درجات الحرارة'],
      ['ما المقصود بالحضارة؟','منجزات المجتمع المادية والفكرية','نوع من المعادن','حالة جوية','شكل هندسي'],
    ],
    'الجغرافية': [
      ['ما الأداة التي تحدد الاتجاهات؟','البوصلة','المجهر','الميزان','المحرار'],
      ['ما الخط الوهمي الذي يقسم الأرض إلى نصفين شمالي وجنوبي؟','خط الاستواء','خط غرينتش','مدار السرطان','مدار الجدي'],
      ['ما الذي يوضحه مقياس الرسم؟','العلاقة بين المسافة على الخريطة والواقع','درجة الحرارة','عدد السكان فقط','اتجاه الرياح فقط'],
      ['أيّ مما يأتي شكل من أشكال سطح الأرض؟','الجبل','الساعة','السحابة فقط','الطريق المرسوم'],
      ['ما المقصود بالمناخ؟','متوسط أحوال الجو لفترة طويلة','حالة الجو في ساعة واحدة','نوع التربة فقط','اتجاه واحد على الخريطة'],
    ],
    'الاقتصاد': [
      ['ما المقصود بالعرض في السوق؟','الكميات التي يرغب المنتجون ببيعها','رغبات المشترين فقط','مقدار المطر','عدد المدارس'],
      ['ما المقصود بالطلب؟','رغبة المستهلكين وقدرتهم على الشراء','كمية السلع المخزونة فقط','تكلفة النقل وحدها','عدد المصانع فقط'],
      ['أيّ مما يأتي يعد مورداً اقتصادياً؟','العمل','اللون','الظل','الصدى'],
      ['ما وظيفة النقود الأساسية؟','وسيط للتبادل','مقياس للطقس','مصدر للأوكسجين','أداة لقياس الطول'],
      ['ماذا تعني الميزانية الشخصية؟','خطة للدخل والنفقات','قائمة بالأسماء','خريطة للمدينة','جدول درجات الحرارة'],
    ],
  };
  final subjectPool = pools[subject] ?? [
    ['أي خيار هو الأنسب للمراجعة الدراسية؟','فهم الفكرة والتدرب عليها','ترك الدرس','اختيار عشوائي دائماً','عدم قراءة السؤال'],
    ['ما أفضل طريقة للتحقق من إجابة؟','مراجعة الدرس والمصدر','تجاهل السؤال','تخمين كل الإجابات','ترك الاختبار'],
  ];
  for (var i = 0; i < 100; i++) {
    final raw = subjectPool[i % subjectPool.length];
    final choices = raw.sublist(1).toList();
    final correctAnswer = choices.first;
    choices.shuffle();
    bank.add(QuizQuestion(raw[0], choices, choices.indexOf(correctAnswer)));
  }
  return bank;
}

class QuizScreen extends StatefulWidget {
  final String grade;
  final String subject;
  const QuizScreen({super.key, required this.grade, required this.subject});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final List<QuizQuestion> questions;
  final Map<int, int> answers = {};
  int index = 0;
  bool finished = false;
  bool reviewing = false;
  @override
  void initState() {
    super.initState();
    questions = makeQuizQuestions(widget.grade, widget.subject);
  }
  int get score => answers.entries.where((e) => questions[e.key].answer == e.value).length;
  void next() {
    if (!answers.containsKey(index)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اختر إجابة أولاً')));
      return;
    }
    if (index == questions.length - 1) {
      quizHistory.add(QuizResult(
        grade: widget.grade,
        subject: widget.subject,
        score: score,
        total: questions.length,
        date: DateTime.now(),
      ));
      saveQuizHistory();
      setState(() => finished = true);
    } else {
      setState(() => index++);
    }
  }
  @override
  Widget build(BuildContext context) {
    final q = questions[index];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text('اختبار ${widget.subject}')),
        body: finished ? (reviewing ? _reviewAnswers() : _result()) : ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text(widget.grade, style: const TextStyle(color: blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: (index + 1) / questions.length, minHeight: 7),
            const SizedBox(height: 10),
            Text('السؤال ${index + 1} من ${questions.length}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 18),
            Card(child: Padding(padding: const EdgeInsets.all(20), child: Text(q.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, height: 1.5)))),
            const SizedBox(height: 12),
            ...List.generate(q.choices.length, (i) {
              final selected = answers[index] == i;
              return Card(
                color: selected ? blue.withOpacity(.10) : null,
                child: RadioListTile<int>(
                  value: i, groupValue: answers[index], activeColor: blue,
                  title: Text('${['أ','ب','ج','د'][i]}. ${q.choices[i]}'),
                  onChanged: (value) => setState(() => answers[index] = value!),
                ),
              );
            }),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: next, icon: Icon(index == questions.length - 1 ? Icons.flag_rounded : Icons.arrow_forward_rounded), label: Text(index == questions.length - 1 ? 'إنهاء الاختبار' : 'السؤال التالي')),
          ],
        ),
      ),
    );
  }
  Widget _result() {
    final percent = (score / questions.length * 100).round();
    return Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(
      mainAxisSize: MainAxisSize.min, children: [
        Icon(percent >= 50 ? Icons.emoji_events_rounded : Icons.menu_book_rounded, size: 72, color: percent >= 50 ? teal : blue),
        const SizedBox(height: 18),
        const Text('انتهى الاختبار', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Text('${widget.subject} — ${widget.grade}'),
        const SizedBox(height: 12),
        Text('$score / ${questions.length}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: blue)),
        Text('النسبة: $percent%'),
        const SizedBox(height: 22),
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('العودة إلى الاختبارات')),
        OutlinedButton.icon(onPressed: () => setState(() => reviewing = true), icon: const Icon(Icons.fact_check_rounded), label: const Text('مراجعة الإجابات الصحيحة والخاطئة')),
        TextButton(onPressed: () => setState(() { answers.clear(); index = 0; finished = false; reviewing = false; }), child: const Text('إعادة الاختبار')),
      ],
    )));
  }

  Widget _reviewAnswers() {
    return ListView(padding: const EdgeInsets.all(16), children: [
      const SectionHeading(title: 'مراجعة الإجابات', subtitle: 'الإجابة الصحيحة لكل سؤال وإجابتك التي اخترتها'),
      const SizedBox(height: 12),
      ...questions.asMap().entries.map((entry) {
        final i = entry.key;
        final q = entry.value;
        final chosen = answers[i];
        final correct = chosen == q.answer;
        return Card(margin: const EdgeInsets.only(bottom: 10), child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('السؤال ${i + 1}: ${q.text}', style: const TextStyle(fontWeight: FontWeight.w800, height: 1.5)),
          const SizedBox(height: 8),
          Text('إجابتك: ${chosen == null ? 'لم تجب' : q.choices[chosen]}', style: TextStyle(color: correct ? teal : Colors.redAccent)),
          Text('الإجابة الصحيحة: ${q.choices[q.answer]}', style: const TextStyle(color: teal, fontWeight: FontWeight.bold)),
        ])));
      }),
      FilledButton(onPressed: () => setState(() => reviewing = false), child: const Text('العودة إلى النتيجة')),
    ]);
  }
}

