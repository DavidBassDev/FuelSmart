import 'package:flutter/material.dart';
import 'package:fuel_smart/core/features/auth/login_screen.dart';
import 'package:fuel_smart/core/features/users/main_screen.dart';
import 'package:fuel_smart/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData currentTheme = AppTheme.wineTheme();

  void changeTheme(ThemeData theme) {
    setState(() {
      currentTheme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: currentTheme, home: const LoginScreen());
  }
}
