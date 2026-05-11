import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _auth = Supabase.instance.client.auth;
  final _db = Supabase.instance.client;

  User? getCurrentUser() => _auth.currentUser;

  Future<void> signInWithEmailPassword(String email, String password) async {
    await _auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    final res = await _auth.signUp(email: email, password: password);
    await _db.from('users').insert({
      'id': res.user!.id,
      'email': email,
    });
  }

  Future<void> signOut() async => await _auth.signOut();
}