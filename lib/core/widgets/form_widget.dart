import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final TextEditingController? controller;

  const FormWidget({
    super.key,
    required this.icon,
    required this.obscureText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          suffixIcon: Icon(icon, color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
