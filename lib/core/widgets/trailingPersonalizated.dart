import 'package:flutter/material.dart';

class Trailingpersonalizated extends StatelessWidget {
  final VoidCallback onPressed;
  const Trailingpersonalizated({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return (ListTile(
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          backgroundColor: const Color(0xFF5C1F2B),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: const Text("Seleccionar"),
      ),
    ));
  }
}
