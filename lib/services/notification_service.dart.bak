import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  // Initialize notifications
  static Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone data
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Karachi')); // Pakistan Standard Time

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      macOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        print('Notification tapped: ${response.payload}');
      },
    );

    _initialized = true;
  }

  // Request permissions (mainly for iOS)
  static Future<bool> requestPermissions() async {
    final androidPlugin =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final iosPlugin = _notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    final macPlugin = _notifications.resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>();

    bool? androidGranted;
    if (androidPlugin != null) {
      androidGranted = await androidPlugin.requestNotificationsPermission();
    }

    bool? iosGranted;
    if (iosPlugin != null) {
      iosGranted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    bool? macGranted;
    if (macPlugin != null) {
      macGranted = await macPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    return androidGranted ?? iosGranted ?? macGranted ?? true;
  }

  // Show immediate notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'project_focus_channel',
      'Project Focus Notifications',
      channelDescription: 'Notifications for task reminders and motivation',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    await _notifications.show(id, title, body, notificationDetails,
        payload: payload);
  }

  // Schedule a notification
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'project_focus_channel',
      'Project Focus Notifications',
      channelDescription: 'Notifications for task reminders and motivation',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  // Schedule daily midnight reset notification
  static Future<void> scheduleDailyReset() async {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, 0, 0);

    // If midnight already passed today, schedule for tomorrow
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await scheduleNotification(
      id: 999,
      title: '🌙 New Day, New Goals!',
      body: 'Your daily tasks have been reset. Time to conquer today!',
      scheduledTime: scheduledTime,
    );
  }

  // Schedule task reminder
  static Future<void> scheduleTaskReminder(Task task) async {
    if (!task.notificationEnabled || task.scheduledTime == null) return;

    final now = DateTime.now();
    if (task.scheduledTime!.isBefore(now)) return;

    await scheduleNotification(
      id: task.id.hashCode,
      title: '⏰ Task Reminder',
      body: 'Time for: ${task.title}',
      scheduledTime: task.scheduledTime!,
      payload: task.id,
    );
  }

  // Send motivational notification
  static Future<void> sendMotivationalNotification(String message) async {
    await showNotification(
      id: 1000,
      title: '💪 Stay Motivated!',
      body: message,
    );
  }

  // Cancel a notification
  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  // Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Get pending notifications (for debugging)
  static Future<List<PendingNotificationRequest>>
      getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}
