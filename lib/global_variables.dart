import 'package:flutter/material.dart';

// --- Opacity Settings ---
double cardOpacity = 1.0;      // Secondary container (cards, tiles)
double primaryOpacity = 0.3;   // Primary color (buttons, current user bubbles)
double textFieldOpacity = 1.0; // Input field background
double drawerOpacity = 0.7;    // Drawer background opacity

// --- Size & Shape Settings ---
double logoHeight = 120.0;
double globalBorderRadius = 16.0;
double chatBubbleRadius = 16.0;
double userTileRadius = 32.0;
double buttonBorderRadius = 16.0;
double drawerBorderRadius = 0.0; // Usually 0 for full-height drawer

// --- Avatar & Icon Sizes ---
double userAvatarSize = 48.0;
double userAvatarIconSize = 20.0;
double drawerIconSize = 24.0;
double searchIconSize = 24.0;
double appBarIconSize = 24.0;

// --- Spacing & Padding ---
double globalPadding = 16.0;
double cardPadding = 16.0;
double chatBubblePaddingVertical = 12.0;
double chatBubblePaddingHorizontal = 16.0;
double userTilePaddingVertical = 16.0;
double userTilePaddingHorizontal = 16.0;
double userTileMarginVertical = 6.0;
double userTileMarginHorizontal = 16.0;
double buttonPadding = 20.0;
double buttonMarginHorizontal = 25.0;

// --- Typography ---
double fontSizeBody = 16.0;
double fontSizeTitle = 28.0;
double fontSizeAppBar = 20.0;
double fontSizeSmall = 14.0;
double fontSizeButton = 16.0;
FontWeight fontWeightBold = FontWeight.bold;
FontWeight fontWeightSemiBold = FontWeight.w600;
FontWeight fontWeightNormal = FontWeight.normal;

// --- Shadows & Effects ---
bool showShadows = true;
double shadowBlurRadius = 8.0;
double shadowOpacity = 0.05;
Offset shadowOffset = const Offset(0, 2);

// --- Animation Durations ---
int animationDurationFast = 200;
int animationDurationNormal = 500;

// --- Component Heights ---
double appBarHeight = 56.0;
double searchBarHeight = 50.0;
double drawerWidthFactor = 0.75; // 75% of screen width

// --- Specific Element Colors (Optional overrides) ---
// Color? customPrimaryColor; // If you want to override theme colors easily


// --- Box Style Settings ---
bool useSquircleForTiles = true;
bool useGlassmorphism = true;
double glassBlur = 10.0;


