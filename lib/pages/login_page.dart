 import 'package:flutter/material.dart';
import 'package:message_app_flutter/authentication/auth_service.dart';
import 'package:message_app_flutter/components/my_textfield.dart';
import 'package:message_app_flutter/components/my_button.dart';

class LoginPage extends StatelessWidget{

  //email and password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final void Function()? onTap;

   LoginPage({
     required this.onTap,
      super.key,
   });

   //login method
  void login(BuildContext context) async{
    //auth service
    final authService = AuthService();
    try{
      await authService.signInWithEmailPassword(emailController.text, pwdController.text,);
    }
    catch (e){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
      ),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        width: double.infinity,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //login
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
              ),
          const SizedBox(height: 29,),
          //welcome back message
          Text("Welcome Back!!",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize : 16,
          ),
    ),
          const SizedBox(height: 29,),
          MyTextfield(
            hintText: "Email",
            obscureText: false,
            controller: emailController,
          ),
          const SizedBox(height: 10,),
          MyTextfield(
            hintText: "Password",
            obscureText: true,
            controller: pwdController,
          ),
          const SizedBox(height: 10,),
          my_button(
            text: "Login",
            onTap: () => login(context),
          ),

          const SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Not a member? ",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              GestureDetector(
                onTap: onTap,
                child: Text("Register Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                ),
                ),
              )
            ],
          )



        ],
      ),
      ),
    );

  }
}