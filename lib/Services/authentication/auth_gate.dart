import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/loginOrReigister.dart';
import 'package:message_app_flutter/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1700), () {
      if (mounted) setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final indicator = LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).colorScheme.primary,size: 50,);
    if (!_ready) return Scaffold(body: Center(child: indicator));

    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData && snapshot.data!.session != null) {
          return HomePage();
        }
        return const LoginOrReigister();
      },
    );
  }
}