import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_const.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notifPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initNotif(RemoteMessage msg) async {
    final AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings notificationSettings = InitializationSettings(
      android: androidSettings,
    );

    await notifPlugin.initialize(
      settings: notificationSettings,

      onDidReceiveNotificationResponse: (details) {
        print("called here ${msg.data}");

        navigateToChatScreen(msg.data);
      },
    );
  }

  void navigateToChatScreen(Map<String, dynamic> payload) {
    if (payload['type'] == "chat") {
      Navigator.of(AppConst.navigatorKey.currentContext!).pushNamed("chat");
    } else {
      Fluttertoast.showToast(msg: "error navigation");
    }
  }

  Future<void> checkNotifPerm() async {
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      AppSettings.openAppSettings();
    }
  }

  Future<void> checkMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      initNotif(msg);

      showNotif(
        title: msg.notification?.title,
        body: msg.notification?.body,
        data: msg.data,
      );
    });
  }

  Future<void> getToken() async {
    final token = await messaging.getToken();
    print(token);
  }

  Future<void> handleBgRedirection() async {
    RemoteMessage? msg = await messaging.getInitialMessage();

    if (msg != null) {
      navigateToChatScreen(msg.data);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg) {
      navigateToChatScreen(msg.data);
    });
  }

  Future<void> showNotif({
    String? title = "hey",
    String? body = "body",
    required Map<String, dynamic> data,
  }) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    print("msg dataaaa ${data}");

    AndroidNotificationDetails notifDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'This is the default notification channel',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    NotificationDetails details = NotificationDetails(android: notifDetails);
    await notifPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,

      body: body,
      title: title,
      notificationDetails: details,
    );
  }
}
