import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:taxi_driver/features/driver/data/models/message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatService {
  final String baseUrl = 'YOUR_API_BASE_URL';
  final String wsUrl = 'wss://YOUR_WEBSOCKET_URL';
  
  WebSocketChannel? _channel;
  String? _currentRideId;
  
  // Callbacks for real-time events
  Function(MessageModel)? _onMessageReceived;
  Function(String)? _onConnectionStatusChanged;
  Function(bool)? _onTypingStatusChanged;

  // Connect to WebSocket for real-time chat
  void connect(String rideId) {
    try {
      _currentRideId = rideId;
      _channel = WebSocketChannel.connect(
        Uri.parse('$wsUrl/chat/$rideId'),
      );
      
      _onConnectionStatusChanged?.call('connecting');
      
      // Listen for messages
      _channel!.stream.listen(
        (data) {
          _handleWebSocketMessage(data);
        },
        onError: (error) {
          print('WebSocket Error: $error');
          _onConnectionStatusChanged?.call('error');
        },
        onDone: () {
          print('WebSocket Connection Closed');
          _onConnectionStatusChanged?.call('disconnected');
        },
      );
      
      _onConnectionStatusChanged?.call('connected');
    } catch (e) {
      print('Failed to connect to WebSocket: $e');
      _onConnectionStatusChanged?.call('failed');
    }
  }

  // Handle incoming WebSocket messages
  void _handleWebSocketMessage(dynamic data) {
    try {
      final Map<String, dynamic> json = jsonDecode(data);
      final String type = json['type'];
      
      switch (type) {
        case 'message':
          final message = MessageModel.fromJson(json['data']);
          _onMessageReceived?.call(message);
          break;
          
        case 'typing':
          final bool isTyping = json['data']['is_typing'];
          _onTypingStatusChanged?.call(isTyping);
          break;
          
        case 'status':
          final String status = json['data']['status'];
          _onConnectionStatusChanged?.call(status);
          break;
      }
    } catch (e) {
      print('Error parsing WebSocket message: $e');
    }
  }

  // Send message through WebSocket
  Future<void> sendMessage(MessageModel message) async {
    try {
      // Send via WebSocket for real-time delivery
      if (_channel != null) {
        final payload = {
          'type': 'message',
          'data': message.toJson(),
        };
        _channel!.sink.add(jsonEncode(payload));
      }
      
      // Also save to server via REST API
      final response = await http.post(
        Uri.parse('$baseUrl/chats/${_currentRideId}/messages'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(message.toJson()),
      );
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to save message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
      throw Exception('Failed to send message');
    }
  }

  // Get chat history from server
  Future<List<MessageModel>> getChatHistory(String rideId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/chats/$rideId/messages'),
        headers: {
          'Authorization': 'Bearer ${_getAuthToken()}',
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> messagesJson = data['messages'];
        return messagesJson
            .map((json) => MessageModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch chat history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chat history: $e');
      return [];
    }
  }

  // Send typing indicator
  void sendTypingIndicator(bool isTyping) {
    if (_channel != null) {
      final payload = {
        'type': 'typing',
        'data': {'is_typing': isTyping},
      };
      _channel!.sink.add(jsonEncode(payload));
    }
  }

  // Event listeners
  void onMessageReceived(Function(MessageModel) callback) {
    _onMessageReceived = callback;
  }

  void onConnectionStatusChanged(Function(String) callback) {
    _onConnectionStatusChanged = callback;
  }

  void onTypingStatusChanged(Function(bool) callback) {
    _onTypingStatusChanged = callback;
  }

  // Disconnect WebSocket
  void disconnect() {
    _channel?.sink.close(status.goingAway);
    _channel = null;
    _currentRideId = null;
    _onConnectionStatusChanged?.call('disconnected');
  }

  // Get authentication token
  String _getAuthToken() {
    return 'your_auth_token_here';
  }
}
