import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/notification_service.dart';
import 'package:flutter_application_3/core/socket_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> x;

  void initState() {
    print("inittt");
    // SocketService().connect();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    x = Tween(begin: 0.0, end: 400.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward();

    _animationController.reverse();

    _animationController.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home screen")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              // var y = compute((callback) => startCompute(), "");
              // var y = await Isolate.run(() => startCompute());

              ReceivePort rp = ReceivePort();

              var y = await Isolate.spawn(startCompute, rp.sendPort);

              rp.listen((message) {
                print("heyyy $message");
              });
            },
            child: Text("computaion"),
          ),

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
          //   AnimatedBuilder(
          //   animation: _animationController,
          //  builder: (context, child) {
          //  return
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => SizedBox(
              height: x.value,
              width: x.value,
              child: Text("hey"),
              //  );
              //  },
            ),
          ),
          AnimatedBuilder(
            animation: x,
            builder: (context, child) => Transform.rotate(
              angle: x.value,
              child: Center(
                child: Container(color: Colors.yellow, height: 100, width: 100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void startCompute(SendPort sp) {
  int x = 0;
  for (var i = 0; i <= 10000000000; i++) {
    x++;
  }
  sp.send(x);
}
