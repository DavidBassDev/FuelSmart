import 'package:flutter/material.dart';

final ThemeData wineTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color(0xFF883955),

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF552235), // botones principales
    onPrimary: Colors.white, // texto sobre botones
    secondary: Color(0xFF552235),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color(0xFF883955),
    onSurface: Colors.white, // texto normal
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  ),
);
