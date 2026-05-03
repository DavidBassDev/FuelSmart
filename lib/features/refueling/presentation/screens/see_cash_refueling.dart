import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/models/refueling.dart';
import 'package:fuel_smart/features/refueling/presentation/widgets/refueling_detail_card.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/card_vehicle.dart';

class SeeCashRefueling extends StatelessWidget {
  final Vehicle vehicle;
  final Refueling refueling;

  const SeeCashRefueling({
    super.key,
    required this.vehicle,
    required this.refueling,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Ver consumo caja menor",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const DividerPersonalizated(thicknessSize: 1),
          CardVehicle(vehicle: vehicle),
          const DividerPersonalizated(thicknessSize: 1),
          RefuelingDetailCard(refueling: refueling),
        ],
      ),
    );
  }
}
