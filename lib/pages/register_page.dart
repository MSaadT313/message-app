import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'package:provider/provider.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';
import 'package:message_app_flutter/global_variables.dart';

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
    void register(BuildContext context)async{
      //get auth service
      final auth = AuthService();
      //password match we create a user
      if(pwdController.text == _confirmpwdController.text){
        try{
          await auth.signUpWithEmailPassword(
            emailController.text, pwdController.text,
          );
        }catch (e){
          if (!context.mounted) return;
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
              title: Text("آپ نے مختلف پاس ورڈ لکھا ہے"),
            ),
        );
      }
      
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Provider.of<ThemeProvider>(context).globalBgPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Image.asset(Provider.of<ThemeProvider>(context).logoPath, height: logoHeight),
                  const SizedBox(height: 32),
                  Text(
                    "نیا اکاؤنٹ بنائیں",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: fontSizeTitle,
                      fontWeight: fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "آئیے آپ کے لیے ایک اکاؤنٹ بناتے ہیں",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: fontSizeBody,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "آپ کے لیے اکاؤنٹ شروع کرتے ہیں.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),
                  MyTextfield(
                    hintText: "ای میل",
                    obscureText: false,
                    controller: emailController,
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hintText: "پاس ورڈ",
                    obscureText: true,
                    controller: pwdController,
                  ),
                  const SizedBox(height: 16),
                  MyTextfield(
                    hintText: "پاس ورڈ دوبارہ لکھیں",
                    obscureText: true,
                    controller: _confirmpwdController,
                  ),
                  const SizedBox(height: 24),
                  MyButton(
                    text: "دستخط کریں",
                    onTap: () => register(context),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("پہلے سے اکاؤنٹ ہے؟ ",
                          style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
                      GestureDetector(
                        onTap: onTap,
                        child: Text(
                          "ابھی لاگ ان کریں",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}
