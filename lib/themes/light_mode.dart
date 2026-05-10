import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: const Color(0xFFF8FAFC),
    primary: const Color(0xFF2563EB),
    secondary: const Color(0xFFE2E8F0),
    tertiary: Colors.white,
    inversePrimary: const Color(0xFF0F172A),
  ),
  scaffoldBackgroundColor: const Color(0xFFF8FAFC),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF8FAFC),
    foregroundColor: Color(0xFF0F172A),
    elevation: 0,
    centerTitle: true,
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  ),
);