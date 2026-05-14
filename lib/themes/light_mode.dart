import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_app_flutter/global_variables.dart';

// ══════════════════════════════════════════════════════════
//  LIGHT THEME — Soft cloud white with warm indigo accents
//  Palette:  #F7F9FC (surface) · #4F46E5 (primary/indigo)
//            #FFFFFF (card) · #E2E8F0 (border)
//            #1E293B (on-surface) · #94A3B8 (subtle)
// ══════════════════════════════════════════════════════════

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.cairoTextTheme(ThemeData.light().textTheme),

  colorScheme: ColorScheme.light(
    surface: const Color(0xFFF7F9FC),
    primary: const Color(0xFF4F46E5),          // Indigo 600
    primaryContainer: const Color(0xFF6366F1), // Indigo 500 – pressed states
    secondary: const Color(0xFFFFFFFF),        // Card/tile background
    tertiary: const Color(0xFF94A3B8),         // Subtle / hint text
    inversePrimary: const Color(0xFF1E293B),   // Primary text (dark on light)
    outline: const Color(0xFFE2E8F0),          // Borders / dividers
    surfaceContainerHighest: const Color(0xFFEEF2F7), // Slightly elevated
  ),

  scaffoldBackgroundColor: const Color(0xFFF7F9FC),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFF1E293B),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Color(0xFF1E293B),
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Color(0xFF1E293B)),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFFFAFBFF),
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(cardBorderRadius),
      side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
    ),
    margin: EdgeInsets.zero,
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFFE2E8F0),
    thickness: 1,
    space: 1,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 1.8),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(globalBorderRadius),
      borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
    ),
  ),

  listTileTheme: const ListTileThemeData(
    iconColor: Color(0xFF64748B),
    textColor: Color(0xFF1E293B),
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((s) =>
    s.contains(WidgetState.selected)
        ? Colors.white
        : const Color(0xFF94A3B8)),
    trackColor: WidgetStateProperty.resolveWith((s) =>
    s.contains(WidgetState.selected)
        ? const Color(0xFF4F46E5)
        : const Color(0xFFE2E8F0)),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF1E293B),
    contentTextStyle: const TextStyle(color: Colors.white),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    behavior: SnackBarBehavior.floating,
  ),
);