import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/components/my_textfield.dart';
import 'package:message_app_flutter/components/my_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:message_app_flutter/global_variables.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  bool _loading = false;

  //--------------------------------------------------
  // LOGIN FUNCTION
  //--------------------------------------------------
  Future<void> login() async {
    setState(() => _loading = true);

    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        emailController.text.trim(),
        pwdController.text.trim(),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("تصدیق ناکام ہوگئی"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  //--------------------------------------------------
  // UI
  //--------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      body: SafeArea(
        child: _loading
            ? Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: theme.colorScheme.primary,
            size: 50,
          ),
        )
            : Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: globalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //--------------------------------------------------
                  // LOGO
                  //--------------------------------------------------
                  Image.asset(
                    'assets/logos/taaluq_dark.png',
                    height: logoHeight,
                  ),

                  const SizedBox(height: 32),

                  //--------------------------------------------------
                  // TITLE
                  //--------------------------------------------------
                  Text(
                    "خوش آمدید",
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: fontWeightBold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "آپ کو دوبارہ دیکھ کر خوشی ہوئی",
                    style: TextStyle(
                      fontSize: fontSizeBody,
                      color: theme.colorScheme.secondary,
                    ),
                  ),

                  const SizedBox(height: 32),

                  //--------------------------------------------------
                  // EMAIL
                  //--------------------------------------------------
                  MyTextfield(
                    hintText: "ای میل",
                    obscureText: false,
                    controller: emailController,
                    onSubmitted: (_) => login(),
                  ),

                  const SizedBox(height: 16),

                  //--------------------------------------------------
                  // PASSWORD
                  //--------------------------------------------------
                  MyTextfield(
                    hintText: "پاس ورڈ",
                    obscureText: true,
                    controller: pwdController,
                    onSubmitted: (_) => login(),
                  ),

                  const SizedBox(height: 24),

                  //--------------------------------------------------
                  // LOGIN BUTTON
                  //--------------------------------------------------
                  MyButton(
                    text: "لاگ ان کریں",
                    onTap: login,
                  ),

                  const SizedBox(height: 24),

                  //--------------------------------------------------
                  // REGISTER LINK
                  //--------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اکاؤنٹ نہیں؟ ",
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "رجسٹر کریں",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
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
    );
  }
}