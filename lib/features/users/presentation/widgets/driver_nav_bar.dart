import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/nav_provider.dart';
import 'package:fuel_smart/features/refueling/presentation/screens/refueling_screen.dart';
import 'package:fuel_smart/features/users/presentation/screens/driver_user_screen.dart';
import 'package:fuel_smart/features/users/presentation/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class DriverNavBar extends StatelessWidget {
  const DriverNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();

    final screens = [
      const DriverUserScreen(),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: const Color(0XFFE0E0E0),
        items: items,
        onTap: (i) {
          context.read<NavProvider>().changeIndex(i);
        },
      ),
    );
  }
}
