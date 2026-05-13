import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app_flutter/global_variables.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
  colorScheme: ColorScheme.dark(
    surface: const Color(0xFF0B0F19),
    primary: const Color(0xFF6366F1).withValues(alpha: primaryOpacity), // Indigo
    secondary: const Color(0xFF1E293B).withValues(alpha: cardOpacity), // Translucent slate
    tertiary: const Color(0xFF334155),
    inversePrimary: const Color(0xFFF8FAFC),
  ),

  scaffoldBackgroundColor: const Color(0xFF0B0F19),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF0B0F19),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E293B).withValues(alpha: textFieldOpacity),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
    ),
  ),
);