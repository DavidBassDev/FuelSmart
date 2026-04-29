import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FuelCircleWidget extends StatelessWidget {
  final double totalGallons;
  final double availableFuel;

  const FuelCircleWidget({
    super.key,
    required this.totalGallons,
    required this.availableFuel,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = availableFuel == 0
        ? 0.0
        : (totalGallons / availableFuel).clamp(0.0, 1.0);

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: CircularPercentIndicator(
        radius: 90.0,
        lineWidth: 18.0,
        percent: percent,
        animation: true,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: colorScheme.primary,
        backgroundColor: colorScheme.primary.withOpacity(0.2),
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_gas_station, size: 40, color: colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              "${totalGallons.toStringAsFixed(2)} / ${availableFuel.toStringAsFixed(2)} Gal.\nConsumidos",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
