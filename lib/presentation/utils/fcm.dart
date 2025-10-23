import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // ✅ استدعِ هذه الدالة مرة واحدة في main() بعد Firebase.initializeApp()
  static Future<void> init() async {
    await _requestPermission();
    await _initLocalNotifications();
    await _getToken();
    _onForegroundMessage(); // أثناء عمل التطبيق
    _onBackgroundOrTerminated(); // لما المستخدم يضغط الإشعار
  }

  // 🔸 طلب الصلاحيات (خصوصًا لأجهزة iOS)
  static Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // 🔸 إنشاء القناة الخاصة بالإشعارات المحلية
  static Future<void> _initLocalNotifications() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 🔸 الحصول على التوكن لتخزينه في السيرفر أو الـ Firestore
  static Future<void> _getToken() async {
    String? token = await _messaging.getToken();
    debugPrint('🔑 FCM Token: $token');
  }

  // ✅ استقبال الرسائل أثناء عمل التطبيق (Foreground)
  static void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 إشعار Foreground: ${message.notification?.title}');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription:
              'This channel is used for important notifications.',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  // ✅ استقبال الرسائل لما التطبيق في الخلفية أو مقفول
  static void _onBackgroundOrTerminated() {
    // لما المستخدم يضغط على الإشعار ويفتح التطبيق
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('🚀 تم فتح التطبيق من إشعار: ${message.data}');
      // هنا تقدر تتعامل مع البيانات — مثلاً التنقل لشاشة معينة
      _handleNotificationClick(message.data);
    });

    // لما التطبيق كان مقفول تمامًا وتم فتحه من إشعار
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("💡 فتح التطبيق من إشعار (terminated): ${message.data}");
        _handleNotificationClick(message.data);
      }
    });
  }

  // 🔸 دالة اختيارية للتعامل مع الضغط على الإشعار
  static void _handleNotificationClick(Map<String, dynamic> data) {
    // مثال: لو أرسلت مع الإشعار data: { "screen": "chat", "id": "123" }
    final screen = data['screen'];
    if (screen == 'chat') {
      debugPrint("🗨️ افتح شاشة المحادثة برقم ${data['id']}");
      // هنا تقدر تستخدم Navigator أو أي logic آخر
    }
  }
}

// 🔸 لازم تكون برة الكلاس
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📦 إشعار من الخلفية: ${message.messageId}');
}

