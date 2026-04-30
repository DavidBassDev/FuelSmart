import 'package:flutter/material.dart';
import 'package:fuel_smart/features/refueling/widgets/card_fuel_performance.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';

class SeeRefuelingsVehicleScreen extends StatelessWidget {
  final Vehicle vehicle;
  final double totalGallons;
  const SeeRefuelingsVehicleScreen({
    super.key,
    required this.vehicle,
    required this.totalGallons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            "Ver rendimiento y consumos",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CardFuelPerformance(vehicle: vehicle, totalGallons: totalGallons),
        ],
      ),
    );
  }
}
