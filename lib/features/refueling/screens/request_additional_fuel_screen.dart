import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';

class RequestAdditionalFuelScreen extends StatelessWidget {
  const RequestAdditionalFuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ampliación de cupo",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          DividerPersonalizated(thicknessSize: 1),
        ],
      ),
    );
  }
}
