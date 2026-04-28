import 'package:flutter/material.dart';
import 'package:fuel_smart/core/theme/app_theme.dart';

enum AppThemeType { wine, red, beige }

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = AppTheme.beige();
  AppThemeType _type = AppThemeType.beige;

  ThemeData get theme => _theme;
  AppThemeType get type => _type;

  void changeTheme(AppThemeType type) {
    _type = type;

    switch (type) {
      case AppThemeType.wine:
        _theme = AppTheme.wineTheme();
        break;
      case AppThemeType.red:
        _theme = AppTheme.redTheme();
        break;
      case AppThemeType.beige:
        _theme = AppTheme.beige();
        break;
    }

    notifyListeners();
  }
}
