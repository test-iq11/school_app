import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class StudyNotificationService {
  StudyNotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (kIsWeb || _initialized) return;
    try {
      tz_data.initializeTimeZones();
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('Etc/UTC'));
      }
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      );
      await _plugin.initialize(settings);
      _initialized = true;
    } catch (_) {
      // UI remains usable if a platform does not implement local notifications.
      _initialized = false;
    }
  }

  static NotificationDetails get _details => const NotificationDetails(
        android: AndroidNotificationDetails(
          'iraqi_study_reminders',
          'تذكيرات مكتبتي',
          channelDescription: 'تنبيهات مراجعة الكتب وتحديثات مكتبة المناهج',
          importance: Importance.high,
          priority: Priority.high,
          enableVibration: true,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
      );

  static Future<bool> _requestPermission() async {
    if (kIsWeb) return false;
    try {
      await initialize();
      if (!_initialized) return false;
      final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final androidGranted = await android?.requestNotificationsPermission();
      final ios = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      final iosGranted = await ios?.requestPermissions(alert: true, badge: true, sound: true);
      return androidGranted != false && iosGranted != false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> showNow({required int id, required String title, required String body}) async {
    if (!await _requestPermission()) return false;
    try {
      await _plugin.show(id, title, body, _details);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    if (kIsWeb || !dateTime.isAfter(DateTime.now())) return false;
    if (!await _requestPermission()) return false;
    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(dateTime, tz.local),
        _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}


