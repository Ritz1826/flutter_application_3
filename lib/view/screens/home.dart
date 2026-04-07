import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/notification_service.dart';
import 'package:flutter_application_3/core/socket_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    print("inittt");
    SocketService().connect();
    super.initState();
  }

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

          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pushNamed("chat");
              // await NotificationService().showNotif();
            },
            child: Text("go to chat"),
          ),
        ],
      ),
    );
  }
}
