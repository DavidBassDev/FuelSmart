import 'package:flutter/material.dart';

class DividerPersonalizated extends StatelessWidget {
  final double thicknessSize;
  const DividerPersonalizated({super.key, required this.thicknessSize});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 20,
      thickness: thicknessSize,
      indent: 20,
      endIndent: 0,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
