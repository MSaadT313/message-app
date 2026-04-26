import 'package:flutter/material.dart';
import 'package:message_app_flutter/authentication/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
class RegisterPage extends StatelessWidget{
final TextEditingController emailController = TextEditingController();
final TextEditingController pwdController = TextEditingController();
final TextEditingController registerController = TextEditingController();
final TextEditingController _confirmpwdController = TextEditingController();

final void Function()? onTap;

  RegisterPage({
    this.onTap,
    super.key
  });
  void register(BuildContext context){
    //get auth service
    final _auth = AuthService();
    //password match we create a user
    if(pwdController.text == _confirmpwdController.text){
      try{
        _auth.signUpWithEmailPassword(
          emailController.text, pwdController.text,
        );
      }catch (e){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
        );
      }
    }
    //if the password donot match we show error to the user to try again
    else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Password donot match!"),
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
              Text("Lets start an account for you.",
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
              MyTextfield(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmpwdController,
              ),
              const SizedBox(height: 10,),



              my_button(
            text: "Register",
            onTap: () => register(context),
            ),

            const SizedBox(height: 10,),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Already have an account ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            GestureDetector(
              onTap: onTap,
              child: Text("Login Now",
              style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              ),
              ),
            )
            ],
            )],
        ),
      ),
    );
  }
}