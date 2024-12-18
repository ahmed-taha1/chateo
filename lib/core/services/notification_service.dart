import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');


      const InitializationSettings initializationSettings =
      InitializationSettings(
        android: initializationSettingsAndroid,
      );

      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // Listen to FCM messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    if (message.notification != null) {
      _showLocalNotification(message);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    // Handle notification when app is in background
    print('Background message: ${message.notification?.title}');
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  // Send welcome notification for first-time users
  Future<void> sendWelcomeNotification(String userId) async {
    try {
      // You would typically send this via your backend
      await _flutterLocalNotificationsPlugin.show(
        0,
        'Welcome!',
        'Thanks for joining our app!',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'welcome_channel',
            'Welcome Channel',
            importance: Importance.high,
          ),
        ),
      );
    } catch (e) {
      print('Error sending welcome notification: $e');
    }
  }
}