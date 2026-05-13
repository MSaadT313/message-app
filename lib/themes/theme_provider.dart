
import 'package:flutter/material.dart';
import 'package:message_app_flutter/themes/light_mode.dart';
import 'dark_mode.dart';


class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = darkMode;

  String? _wallpaperKey = 'generic';

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;
  
  String? get currentWallpaper {
    if (_wallpaperKey == null) return null;
    if (!isDarkMode) {
      String key = _wallpaperKey == 'math' ? 'maths' : _wallpaperKey!;
      return 'assets/images_light/doodles_$key.png';
    } else {
      return 'assets/images_dark/doodles_$_wallpaperKey.png';
    }
  }

  String get logoPath {
    return isDarkMode ? 'assets/logos/taaluq_dark.png' : 'assets/logos/taaluq_light.png';
  }

  String get globalBgPath {
    return isDarkMode ? 'assets/background/dark_urdu_bg.jpg' : 'assets/background/light_urdu_bg.jpg';
  }

  String? get currentWallpaperKey => _wallpaperKey;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }

  void setWallpaperKey(String? key){
    _wallpaperKey = key;
    notifyListeners();
  }
}