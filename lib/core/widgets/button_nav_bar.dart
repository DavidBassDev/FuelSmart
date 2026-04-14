import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fuel_smart/features/refueling/screens/refueling_screen.dart';
import 'package:fuel_smart/features/users/screens/main_screen.dart';
import 'package:fuel_smart/core/providers/nav_provider.dart';
import 'package:fuel_smart/features/users/screens/profile_screen.dart';
import 'package:provider/provider.dart';

// ALMACENAR TODOS LOS SCREENS ACA
class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();

    final screens = [
      const MainScreen(),
      const RefuelingScreen(),
      const ProfileScreen(),
    ];

    final items = const <Widget>[
      Icon(Icons.home, size: 30, color: Colors.black),
      Icon(Icons.local_gas_station, size: 30, color: Colors.black),
      Icon(Icons.person, size: 30, color: Colors.black),
    ];

    return Scaffold(
      body: screens[nav.index],

      bottomNavigationBar: CurvedNavigationBar(
        index: nav.index,
        backgroundColor: const Color(0xFF552235),
        color: const Color(0XFFE0E0E0),
        items: items,
        onTap: (i) {
          context.read<NavProvider>().changeIndex(i);
        },
      ),
    );
  }
}
