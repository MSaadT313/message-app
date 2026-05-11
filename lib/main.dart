import 'package:flutter/material.dart';
import 'Services/authentication/auth_gate.dart';
import 'themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qmytmmnswvwfdygyxssh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFteXRtbW5zd3Z3ZmR5Z3l4c3NoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg0MjMzNjYsImV4cCI6MjA5Mzk5OTM2Nn0.TbUdGtFQlHLDzfXHrq8jj8mjIxBHQXtMVLnL3CT_rsk',
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}