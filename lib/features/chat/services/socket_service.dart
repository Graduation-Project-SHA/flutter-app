import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:hive/hive.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? _socket;
  bool isConnected = false;

  Function(String event, dynamic data)? onEventReceived;

  void connect() {
    if (isConnected) return;

    final authBox = Hive.box('authBox');
    final token = authBox.get('accessToken');
    print("🔑 Connecting with token: ${token?.substring(0,10)}...");
    const url = "http://api.wiqaya-app.me";

    _socket?.dispose();

    _socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .disableAutoConnect()
          .setPath('/socket.io/')
          .enableReconnection()
          .setReconnectionDelay(3000)
          .setReconnectionAttempts(10)
          .setExtraHeaders({
        if (token != null) 'Authorization': 'Bearer $token',
      })
          .build(),
    );

    try {
      print("🔌 SOCKET CONNECTING...");

      _socket!.onConnect((_) {
        isConnected = true;
        print("✅ SOCKET CONNECTED");
        onEventReceived?.call("socket_ready", null);
      });

      _socket!.onDisconnect((_) {
        isConnected = false;
        print("🛑 SOCKET DISCONNECTED");
      });

      _socket!.onConnectError((error) {
        print("❌ SOCKET CONNECT ERROR: $error");
      });

      _socket!.onError((error) {
        print("❗ SOCKET ERROR: $error");
      });

      _socket!.onReconnect((_) {
        print("🔄 SOCKET RECONNECTED SUCCESSFULLY");
        onEventReceived?.call("socket_ready", null);
      });

      _bindForwardedEvents();
      _socket!.connect();

    } catch (e) {
      print("⚠️ CONNECTION EXCEPTION: $e");
    }
  }

  void _bindForwardedEvents() {
    const events = [
      'join_chat_success',
      'receive_message',
      'message_sent',
      'update_inbox',
    ];

    for (final event in events) {
      _socket!.on(event, (data) {
        onEventReceived?.call(event, data);
      });
    }
  }

  void emitEvent({required String event, required dynamic data}) {
    if (_socket != null && isConnected) {
      _socket!.emit(event, data);
      print("📤 EMIT: $event => $data");
    } else {
      print("⚠️ SOCKET NOT CONNECTED - CANNOT EMIT");
    }
  }

  void sendMessage({required String event, required dynamic data}) {
    emitEvent(event: event, data: data);
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    isConnected = false;
  }
}