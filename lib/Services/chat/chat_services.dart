import 'package:supabase_flutter/supabase_flutter.dart';

class ChatServices {
  final _db = Supabase.instance.client;
  final _auth = Supabase.instance.client.auth;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _db.from('users').stream(primaryKey: ['id']);
  }

  Future<void> sendMessage(String receiverID, String message) async {
    final currentUserID = _auth.currentUser!.id;
    final currentUserEmail = _auth.currentUser!.email!;
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    //print("sender: $currentUserID, receiver: $receiverID, msg: $message");
    await _db.from('messages').insert({
     'sender_id': currentUserID,
     'receiver_id': receiverID,
     'chat_room_id': chatRoomID,
     'message': message,
     'timestamp': DateTime.now().toIso8601String(),
   });
  }

  Stream<List<Map<String, dynamic>>> getMessages(String userID, String otherUserID) {
  List<String> ids = [userID, otherUserID];
  ids.sort();
  String chatRoomID = ids.join('_');

  return _db
      .from('messages')
      .stream(primaryKey: ['id'])
      .eq('chat_room_id', chatRoomID)
      .order('timestamp', ascending: true);
}
}