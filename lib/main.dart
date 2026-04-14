import 'package:flutter/material.dart';
import 'package:fuel_smart/features/auth/screens/login_screen.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/providers/nav_provider.dart';
import 'package:fuel_smart/core/theme/app_theme.dart';
import 'package:fuel_smart/core/widgets/button_nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
    final auth = Provider.of<AuthProvider>(context);

    return MaterialApp(
      theme: currentTheme,
      home: auth.isLogged ? const ButtonNavBar() : const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
