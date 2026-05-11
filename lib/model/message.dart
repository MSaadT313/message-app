class Message {
  final String message;
  final String senderID;
  final String receiverID;
  final DateTime timestamp;

  Message({
    required this.senderID,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderID,
      'receiver_id': receiverID,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderID: map['sender_id'] ?? '',
      receiverID: map['receiver_id'] ?? '',
      message: map['message'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}