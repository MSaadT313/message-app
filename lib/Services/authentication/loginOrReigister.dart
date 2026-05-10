import 'package:flutter/material.dart';
import 'package:message_app_flutter/pages/login_page.dart';
import 'package:message_app_flutter/pages/register_page.dart';

class LoginOrReigister extends StatefulWidget {
  const LoginOrReigister({super.key});

  @override
  State<LoginOrReigister> createState() => _LoginOrRegisterState();
}
//show the login page initially

class _LoginOrRegisterState extends State<LoginOrReigister> {
  bool showLoginPage = true;
void togglePages(){
  setState(() {
    showLoginPage = !showLoginPage;
  });
}
  @override
  Widget build(BuildContext context) {
  if(showLoginPage){
    return LoginPage(
      onTap: togglePages,
    );
  }else{
    return RegisterPage(
      onTap: togglePages,
    );
  }
  }
}
