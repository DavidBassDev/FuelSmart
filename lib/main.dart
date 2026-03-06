import 'package:flutter/material.dart';
import 'package:fuel_smart/core/features/auth/login_screen.dart';
import 'package:fuel_smart/core/theme/wine_Theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen(), theme: wineTheme);
  }
}
