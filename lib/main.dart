import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/themee_provider.dart';
import 'package:fuel_smart/features/auth/screens/login_screen.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/providers/nav_provider.dart';
import 'package:fuel_smart/core/theme/app_theme.dart';
import 'package:fuel_smart/core/widgets/button_nav_bar.dart';
import 'package:fuel_smart/features/users/screens/driver_user_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
  ThemeData currentTheme = AppTheme.beige();

  void changeTheme(ThemeData theme) {
    setState(() {
      currentTheme = theme;
    });
  }

  Widget _getHomeByRole(AuthProvider auth) {
    final role = auth.user?.rol;

    switch (role) {
      case 'admin':
        return const ButtonNavBar();

      case 'conductor':
        return const DriverUserScreen();

      default:
        return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      theme: themeProvider.theme, //provider del tema
      home: auth.isLogged ? _getHomeByRole(auth) : const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
