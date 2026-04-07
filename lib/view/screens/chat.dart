import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/core/socket_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> myMessages = [];

  final socket = SocketService();

  TextEditingController text1 = TextEditingController();

  TextEditingController text2 = TextEditingController();

  @override
  void initState() {
    super.initState();

    socket.addMessage1("heyyy"); // ✅ MUST CALL

    socket.receiveMessage((msg) {
      print("hthis is it " + msg["time"]);

      int time = DateTime.parse(msg["time"]).millisecondsSinceEpoch;
      setState(() {
        myMessages.add({
          "msg": msg["message"],
          "username": msg['username'],
          "time": time,
        });

        myMessages.sort((a, b) => b['time'].compareTo(a['time']));
      });

      print("msgsss" + myMessages.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("chat screen")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              itemCount: myMessages.length,
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemBuilder: (context, index) {
                if (myMessages[index]["username"] == "abc1") {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue,

                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(myMessages[index]["msg"]),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(myMessages[index]["username"]),
                    ),
                  );
                }
              },
            ),
          ),

          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: text1,
                    decoration: InputDecoration(hintText: "Type here...1"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    socket.addMessage1(text1.text);
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: text2,
                    decoration: InputDecoration(hintText: "Type here...2"),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    socket.addMessage2(text2.text);
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
