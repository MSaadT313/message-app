import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_service.dart';
import 'package:message_app_flutter/components/my_button.dart';
import 'package:message_app_flutter/components/my_textfield.dart';
import 'package:message_app_flutter/global_variables.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  RegisterPage({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController pwdController =
  TextEditingController();

  final TextEditingController confirmPwdController =
  TextEditingController();

  // =====================================================
  // REGISTER
  // =====================================================

  Future<void> register(BuildContext context) async {

    final auth = AuthService();

    // =====================================================
    // PASSWORD CHECK
    // =====================================================

    if (pwdController.text.trim() !=
        confirmPwdController.text.trim()) {

      showDialog(

        context: context,

        builder: (context) {

          return const AlertDialog(
            title: Text("آپ نے مختلف پاس ورڈ لکھا ہے"),
          );
        },
      );

      return;
    }

    // =====================================================
    // CREATE ACCOUNT
    // =====================================================

    try {

      await auth.signUpWithEmailPassword(

        emailController.text.trim(),

        pwdController.text.trim(),
      );

    } catch (e) {

      if (!context.mounted) return;

      showDialog(

        context: context,

        builder: (context) {

          return AlertDialog(
            title: Text(e.toString()),
          );
        },
      );
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<ThemeProvider>();

    final background = theme.wallpaper;

    return Stack(

      children: [

        // =====================================================
        // WALLPAPER
        // =====================================================

        if (background != null)

          Positioned.fill(

            child: Image.asset(

              background,

              fit: BoxFit.cover,
            ),
          ),

        // =====================================================
        // DARK OVERLAY
        // =====================================================

        if (background != null && theme.isDarkMode)

          Positioned.fill(

            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),

        // =====================================================
        // MAIN UI
        // =====================================================

        Scaffold(

          backgroundColor:
          background == null
              ? Theme.of(context).colorScheme.surface
              : Colors.transparent,

          body: SafeArea(

            child: Center(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),

                child: Container(

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(

                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(0.88),

                    borderRadius:
                    BorderRadius.circular(28),

                    border: Border.all(

                      color: Theme.of(context)
                          .colorScheme
                          .outline,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black.withOpacity(0.12),

                        blurRadius: 18,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.center,

                    children: [

                      // =====================================================
                      // LOGO
                      // =====================================================

                      Image.asset(

                        theme.logoPath,

                        height: logoHeight,
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // TITLE
                      // =====================================================

                      Text(

                        "نیا اکاؤنٹ بنائیں",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: fontSizeTitle,

                          fontWeight: fontWeightBold,

                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(

                        "آئیے آپ کے لیے ایک اکاؤنٹ بناتے ہیں",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: fontSizeBody,

                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(

                        "آپ کے لیے اکاؤنٹ شروع کرتے ہیں",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 15,

                          color: Theme.of(context)
                              .colorScheme
                              .tertiary,
                        ),
                      ),

                      const SizedBox(height: 34),

                      // =====================================================
                      // EMAIL
                      // =====================================================

                      MyTextfield(

                        hintText: "ای میل",

                        obscureText: false,

                        controller: emailController,
                      ),

                      const SizedBox(height: 18),

                      // =====================================================
                      // PASSWORD
                      // =====================================================

                      MyTextfield(

                        hintText: "پاس ورڈ",

                        obscureText: true,

                        controller: pwdController,
                      ),

                      const SizedBox(height: 18),

                      // =====================================================
                      // CONFIRM PASSWORD
                      // =====================================================

                      MyTextfield(

                        hintText: "پاس ورڈ دوبارہ لکھیں",

                        obscureText: true,

                        controller: confirmPwdController,
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // REGISTER BUTTON
                      // =====================================================

                      MyButton(

                        text: "دستخط کریں",

                        onTap: () => register(context),
                      ),

                      const SizedBox(height: 28),

                      // =====================================================
                      // LOGIN
                      // =====================================================

                      Row(

                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [

                          Text(

                            "پہلے سے اکاؤنٹ ہے؟ ",

                            style: TextStyle(

                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiary,
                            ),
                          ),

                          GestureDetector(

                            onTap: onTap,

                            child: Text(

                              "ابھی لاگ ان کریں",

                              style: TextStyle(

                                fontWeight: FontWeight.bold,

                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}