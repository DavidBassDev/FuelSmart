import 'package:flutter/material.dart';
import 'package:fuel_smart/core/theme/text_theme.dart';

class AppTheme {
  static ThemeData wineTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "SFProText",
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

      textTheme: appTextTheme,
    );
  }

  //color rojo
  static ThemeData redTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFFA23B3C),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFA23B3C), // botones principales
        onPrimary: Colors.white, // texto sobre botones
        secondary: Color(0XFF6E2324),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Color(0xFFA23B3C),
        onSurface: Colors.white, // texto normal
      ),
    );
  }

  //Tema 2
  //color rojo
  static ThemeData beige() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFFF1EDE5),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF2D3E2D), // botones principales
        onPrimary: Colors.white, // texto sobre botones
        secondary: Color(0xFFC9C0AB), //para pantalla login
        onSecondary: Color(0xFF9DAF89), //verde para widgets
        error: Colors.red,
        onError: Colors.white,
        surface: Color(0xFFD4A374), //naranja claro
        onSurface: Color.fromARGB(255, 0, 0, 0), // texto normal
      ),
    );
  }
}
