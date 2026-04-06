import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/app_const.dart';
import 'package:flutter_application_3/core/notification_service.dart';
import 'package:flutter_application_3/view/screens/chat.dart';
import 'package:flutter_application_3/view/screens/home.dart';

@pragma('vm:entry-point')
Future<void> _bgMsgHandling(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_bgMsgHandling);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      NotificationService().checkMessage();
      NotificationService().getToken();
      NotificationService().handleBgRedirection();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppConst.navigatorKey,
      title: 'Flutter Demo',
      routes: {"chat": (context) => ChatScreen()},
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
