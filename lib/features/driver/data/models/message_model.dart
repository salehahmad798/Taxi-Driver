class MessageModel {
  final String id;
  final String rideId;
  final String content;
  final DateTime timestamp;
  final bool isFromDriver;
  final String senderName;
  final String? messageType; // text, image, location, etc.

  MessageModel({
    required this.id,
    required this.rideId,
    required this.content,
    required this.timestamp,
    required this.isFromDriver,
    required this.senderName,
    this.messageType = 'text',
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      rideId: json['ride_id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      isFromDriver: json['is_from_driver'],
      senderName: json['sender_name'],
      messageType: json['message_type'] ?? 'text',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ride_id': rideId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'is_from_driver': isFromDriver,
      'sender_name': senderName,
      'message_type': messageType,
    };
  }
}
