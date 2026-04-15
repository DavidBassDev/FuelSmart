import 'package:flutter/material.dart';

class PillBtnPersonalizated extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool? selected;

  const PillBtnPersonalizated({
    super.key,
    required this.text,
    this.onTap,
    this.textStyle,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    var colorSelectedBtm = const Color.fromARGB(255, 255, 255, 255);
    var colorSelectedTxt = const Color.fromARGB(255, 0, 0, 0);
    if (selected == (true)) {
      colorSelectedBtm = const Color.fromARGB(255, 0, 0, 0);
      colorSelectedTxt = const Color.fromARGB(255, 255, 255, 255);
    }
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: colorSelectedBtm,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style:
              textStyle ??
              TextStyle(
                color: colorSelectedTxt,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
