import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _singleton = SocketManager._internal();

  factory SocketManager() {
    return _singleton;
  }

  SocketManager._internal();

  late IO.Socket socket;
  static const socketUrl =
      'https://sputnik.mynu.app'; // Replace with your sample URL

  void initializeSocket() {
    socket = IO.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to the server
    socket.connect();

    // Listen for connect event
    socket.on('connect', (_) {
      print('Socket connected');

      // socket.emit("deviceSync", {"restaurantId": "5d68ad588085a04652357431"})
    });

    // Listen for disconnect event
    socket.on('disconnect', (_) {
      print('Socket disconnected');
    });

    // Listen for events
    // socket.on('yourEventName', (data) {
    //   print('Received event: $data');
    //   // Handle the event data as needed
    // });
  }
}
