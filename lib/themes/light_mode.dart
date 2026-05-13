import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app_flutter/global_variables.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),
  colorScheme: ColorScheme.light(
    surface: const Color(0xFFF4F7FB),
    primary: const Color(0xFF4F46E5).withValues(alpha: primaryOpacity), // Indigo
    secondary: const Color(0xFFFFFFFF).withValues(alpha: cardOpacity), // Translucent white
    tertiary: const Color(0xFF94A3B8), // Soft slate
    inversePrimary: const Color(0xFF1E293B), // Dark slate
  ),
  scaffoldBackgroundColor: const Color(0xFFF4F7FB),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFF1E293B),
    elevation: 0,
    centerTitle: true,
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white.withValues(alpha: textFieldOpacity),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
    ),
  ),
);