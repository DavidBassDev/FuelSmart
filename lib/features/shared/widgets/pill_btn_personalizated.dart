import 'package:flutter/material.dart';

class PillBtnPersonalizated extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;

  const PillBtnPersonalizated({
    super.key,
    required this.text,
    this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style:
              textStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
