import 'package:cloud_firestore/cloud_firestore.dart';


class Message {
  final String message;
  final String senderID;
  final String receiverID;
  final String senderEmail;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
});

  Map<String, dynamic> toMap(){
    return {
      'senderID' : senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}