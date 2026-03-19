import 'package:flutter/material.dart';

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Icons.home, true),
          _item(Icons.emoji_transportation, true),
          _item(Icons.person, true),
        ],
      ),
    );
  }

  Widget _item(IconData icon, bool selected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? Colors.grey[300] : Colors.transparent,
      ),
      child: Icon(icon, size: 28, color: Colors.black),
    );
  }
}
