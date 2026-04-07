import 'package:socket_io_client/socket_io_client.dart' as IOsock;

class SocketService {
  late IOsock.Socket socket;

  static final SocketService instance = SocketService._internal();

  factory SocketService() {
    return instance;
  }

  SocketService._internal() {
    socket = IOsock.io(
      "http://192.168.1.6:3000",
      IOsock.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
  }

  void connect() async {
    socket.onError((handler) {
      print("error" + handler.toString());
    });

    socket.onConnect((handler) {
      print("connected");
      socket.emit("joinRoom", {"roomId": "room1", "username": "abc"});
      addMessage1("heyy");
    });

    socket.onDisconnect((handler) {
      print("disconnected");
    });

    socket.onReconnect((handler) {
      print("reconnected");
    });

    socket.onConnectError((handler) {
      print("connect error" + handler.toString());
    });

    // receiveMessage();
  }

  void addMessage1(String msg) {
    socket.emit("sendMessage", {
      "message": msg,
      "roomId": "room1",
      "username": "abc1",
    });
    print("msg sent");
  }

  void addMessage2(String msg) {
    socket.emit("sendMessage", {
      "message": msg,
      "roomId": "room1",
      "username": "abc2",
    });
    print("msg sent");
  }

  void receiveMessage(Function(dynamic) handler) {
    socket.off('receiveMessage');
    socket.on('receiveMessage', (data) {
      handler(data); // ✅ CALL the function
    });
  }
}
