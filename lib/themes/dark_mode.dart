import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app_flutter/global_variables.dart';

// ══════════════════════════════════════════════════════════
//  DARK THEME — Deep navy with warm indigo accents
//  Palette:  #0A0E1A (surface) · #6366F1 (primary/indigo)
//            #1A1F35 (card) · #2A3050 (tertiary)
//            #F1F5F9 (on-surface) · #94A3B8 (subtle)
// ══════════════════════════════════════════════════════════

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),

  colorScheme: ColorScheme.dark(
    surface: const Color(0xFF0A0E1A),
    primary: const Color(0xFF6366F1),          // Indigo 500
    primaryContainer: const Color(0xFF4F46E5), // Indigo 600 – pressed states
    secondary: const Color(0xFF1A1F35),        // Card/tile background
    tertiary: const Color(0xFF64748B),         // Subtle / hint text
    inversePrimary: const Color(0xFFF1F5F9),   // Primary text
    outline: const Color(0xFF2A3050),          // Borders / dividers
    surfaceContainerHighest: const Color(0xFF141828), // Elevated surfaces
  ),

  scaffoldBackgroundColor: const Color(0xFF0A0E1A),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFFF1F5F9),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFFF1F5F9),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Color(0xFFF1F5F9)),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF0D1120),
  ),

  cardTheme: CardThemeData(
    color: const Color(0xFF1A1F35),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardBorderRadius),
    ),
    margin: EdgeInsets.zero,
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFF2A3050),
    thickness: 1,
    space: 1,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1A1F35),
    hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 15),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFF2A3050), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.8),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
    ),
  ),

  listTileTheme: const ListTileThemeData(
    iconColor: Color(0xFF94A3B8),
    textColor: Color(0xFFF1F5F9),
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((s) =>
    s.contains(WidgetState.selected)
        ? Colors.white
        : const Color(0xFF64748B)),
    trackColor: WidgetStateProperty.resolveWith((s) =>
    s.contains(WidgetState.selected)
        ? const Color(0xFF6366F1)
        : const Color(0xFF2A3050)),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF1A1F35),
    contentTextStyle: const TextStyle(color: Color(0xFFF1F5F9)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
  ),
);
