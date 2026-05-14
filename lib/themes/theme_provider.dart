import 'package:flutter/material.dart';
import 'package:message_app_flutter/themes/light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData _themeData = darkMode;

  /// SINGLE WALLPAPER STATE
  String? _wallpaperKey = 'generic';

  // =====================================================
  // THEME
  // =====================================================

  ThemeData get themeData => _themeData;

  bool get isDarkMode =>
      _themeData.brightness == Brightness.dark;

  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }

  // =====================================================
  // LOGO
  // =====================================================

  String get logoPath =>
      isDarkMode
          ? 'assets/logos/taaluq_dark.png'
          : 'assets/logos/taaluq_light.png';

  // =====================================================
  // WALLPAPER
  // =====================================================

  String? get wallpaper {

    if (_wallpaperKey == null) return null;

    return isDarkMode
        ? 'assets/images_dark/doodles_$_wallpaperKey.png'
        : 'assets/images_light/doodles_$_wallpaperKey.png';
  }

  String? get wallpaperKey => _wallpaperKey;

  bool get hasWallpaper => _wallpaperKey != null;

  void setWallpaper(String? key) {
    _wallpaperKey = key;
    notifyListeners();
  }
}