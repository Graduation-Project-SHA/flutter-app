import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:hive/hive.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  WebSocketChannel? _channel;
  bool isConnected = false;
  Timer? _pingTimer;
  Timer? _reconnectTimer;

  Function(String event, dynamic data)? onEventReceived;

  String? _userId;

  void connect(String userId) {
    _userId = userId;

    if (isConnected) return;

    final authBox = Hive.box('authBox');
    final token = authBox.get('accessToken');

    final url = Uri.parse(
      "ws://api.wiqaya.duckdns.org/socket.io/?EIO=4&transport=websocket&userId=$userId&token=$token",
    );

    try {
      _channel = WebSocketChannel.connect(url);
      print(" SOCKET CONNECTING...");

      _channel!.stream.listen(
            (rawMessage) => _handleIncomingMessage(rawMessage),
        onError: (error) {
          print(" SOCKET ERROR: $error");
          _handleDisconnect();
        },
        onDone: () {
          print(" SOCKET CLOSED");
          _handleDisconnect();
        },
      );
    } catch (e) {
      print(" CONNECTION ERROR: $e");
      _handleDisconnect();
    }
  }

  void _handleDisconnect() {
    isConnected = false;
    _stopHeartbeat();


    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      if (_userId != null) {
        print(" RECONNECTING...");
        connect(_userId!);
      }
    });
  }

  void _handleIncomingMessage(dynamic rawMessage) {
    String msg = rawMessage.toString();
    print(" $msg");

    if (msg.startsWith('0')) {
      _channel!.sink.add("40");
      _startHeartbeat();
    } else if (msg.startsWith('40')) {
      isConnected = true;
      print("SOCKET CONNECTED");
      onEventReceived?.call("socket_ready", null);
    } else if (msg.startsWith('42')) {
      try {
        final decoded = jsonDecode(msg.substring(2));
        final eventName = decoded[0];
        final eventData = decoded[1];

        onEventReceived?.call(eventName, eventData);
      } catch (e) {
        print(" Decode Error: $e");
      }
    } else if (msg == "2") {
      _channel!.sink.add("3");
    }
  }

  void sendMessage({required String event, required dynamic data}) {
    if (_channel != null && isConnected) {
      final payload = '42["$event", ${jsonEncode(data)}]';
      _channel!.sink.add(payload);
      print(" $payload");
    } else {
      print(" SOCKET NOT CONNECTED");
    }
  }

  void _startHeartbeat() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (isConnected) {
        _channel!.sink.add("2");
      }
    });
  }

  void _stopHeartbeat() {
    _pingTimer?.cancel();
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _stopHeartbeat();
    _channel?.sink.close(status.goingAway);
    isConnected = false;
  }
}