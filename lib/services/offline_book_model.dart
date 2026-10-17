
class OfflineBookInfo {
  final String key;
  final String title;
  final String grade;
  final String subject;
  final String url;
  final String path;

  const OfflineBookInfo({
    required this.key,
    required this.title,
    required this.grade,
    required this.subject,
    required this.url,
    required this.path,
  });

  Map<String, dynamic> toJson() => {
        'key': key,
        'title': title,
        'grade': grade,
        'subject': subject,
        'url': url,
        'path': path,
      };

  factory OfflineBookInfo.fromJson(Map<String, dynamic> json) => OfflineBookInfo(
        key: json['key'] as String? ?? '',
        title: json['title'] as String? ?? 'كتاب محفوظ',
        grade: json['grade'] as String? ?? '',
        subject: json['subject'] as String? ?? '',
        url: json['url'] as String? ?? '',
        path: json['path'] as String? ?? '',
      );
}

