import 'package:flutter/material.dart';
import 'package:message_app_flutter/authentication/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void logout(){
  //get auth service
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Home"),
        actions: [
          IconButton(onPressed: logout ,icon: Icon(Icons.logout),)
        ],
      ),
    );
  }
}
