import 'package:flutter/material.dart';

class DividerPersonalizated extends StatelessWidget {
  const DividerPersonalizated({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20,
      thickness: 5,
      indent: 20,
      endIndent: 0,
      color: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}
