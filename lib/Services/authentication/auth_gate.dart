import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/loginOrReigister.dart';
import 'package:message_app_flutter/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.session != null) {
          return HomePage();
        }
        return const LoginOrReigister();
      },
    );
  }
}