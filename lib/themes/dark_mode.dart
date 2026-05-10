import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF0F172A),
    primary: Color(0xFF3B82F6),
    secondary: Color(0xFF1E293B),
    tertiary: Color(0xFF334155),
    inversePrimary: Color(0xFFF8FAFC),
  ),

  scaffoldBackgroundColor: const Color(0xFF020617),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0F172A),
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF0F172A),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E293B),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  ),
);