import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fuel_alert/core/routes/app/app-route-names.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  log("Title ${message.notification?.title}");
  log("Body ${message.notification?.body}");
  log("Payload ${message.data}");
  log("Payload $message");

}

class FirebaseApiService {

  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null)  return;

    Get.toNamed(
      notificationView,
    );
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings("@drawable/logo");
    const settings = InitializationSettings(
      android: android,
      iOS: iOS
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload as String));
        handleMessage(message);
      }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body, 
        NotificationDetails(
          iOS: const DarwinNotificationDetails(
              presentAlert: true,  // Display an alert
              presentBadge: true,  // Update badge number
              presentSound: true,  
          ),
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/logo",
          ),
        ),
        payload: jsonEncode(message.toMap())
      );

    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // final fcmToken = await LocalStorage().fetchFCMToken();
    // log("FCM TOKEN: $fcmToken");
    initPushNotifications();
    initLocalNotifications();
  }
  
}