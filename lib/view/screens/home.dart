import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home screen")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await NotificationService().checkNotifPerm();
              // await NotificationService().showNotif();
            },
            child: Text("trigger"),
          ),
        ],
      ),
    );
  }
}
