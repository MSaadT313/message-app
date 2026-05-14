import 'package:flutter/material.dart';
import 'package:message_app_flutter/Services/authentication/auth_gate.dart';
import 'package:message_app_flutter/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:message_app_flutter/supabase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseOptions.url,
    anonKey: SupabaseOptions.anonKey,
  );

  runApp(

    ChangeNotifierProvider<ThemeProvider>(

      create: (_) => ThemeProvider(),

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(

      builder: (context, themeProvider, child) {

        return MaterialApp(

          debugShowCheckedModeBanner: false,

          theme: themeProvider.themeData,

          home: const AuthGate(),
        );
      },
    );
  }
}