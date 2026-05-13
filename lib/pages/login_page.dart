import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/components/my_textfield.dart';
import 'package:message_app_flutter/components/my_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:message_app_flutter/themes/dark_mode.dart';
import 'package:message_app_flutter/global_variables.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({required this.onTap, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  bool _loading = false;

  void login(BuildContext context) async {
    setState(() => _loading = true);
    final authService = AuthService();
    final nav = Navigator.of(context);
    try {
      await authService.signInWithEmailPassword(emailController.text, pwdController.text);
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showDialog(
        context: nav.context,
        builder: (context) => AlertDialog(
          title: const Text("تصدیق ناکام ہوگئی"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkMode,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/dark_urdu_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _loading
              ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: darkMode.colorScheme.primary, size: 50))
              : SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/logos/taaluq_dark.png', height: logoHeight),
                            const SizedBox(height: 32),
                            Text(
                              "خوش آمدید",
                              style: TextStyle(
                                color: darkMode.colorScheme.inversePrimary,
                                fontSize: fontSizeTitle,
                                fontWeight: fontWeightBold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "آپ کو دوبارہ دیکھ کر خوشی ہوئی",
                              style: TextStyle(
                                color: darkMode.colorScheme.inversePrimary,
                                fontSize: fontSizeBody,
                              ),
                            ),
                            const SizedBox(height: 32),
                            MyTextfield(
                              hintText: "ای میل",
                              obscureText: false,
                              controller: emailController,
                              onSubmitted: (_) => login(context),
                            ),
                            const SizedBox(height: 16),
                            MyTextfield(
                              hintText: "پاس ورڈ",
                              obscureText: true,
                              controller: pwdController,
                              onSubmitted: (_) => login(context),
                            ),
                            const SizedBox(height: 24),
                            MyButton(
                              text: "لاگ ان کریں",
                              onTap: () => login(context),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("اکاؤنٹ نہیں؟ ",
                                    style: TextStyle(color: darkMode.colorScheme.tertiary)),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: Text(
                                    "رجسٹر کریں",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: darkMode.colorScheme.primary,
                                    ),
                                  ),
                                ),
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
      ),
    );
  }
}