import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/models/refueling.dart';
import 'package:fuel_smart/features/refueling/widgets/refueling_detail_card.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/widgets/card_vehicle.dart';

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
        title: Text(
          "Ver consumo caja menor",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          DividerPersonalizated(thicknessSize: 1),
          CardVehicle(vehicle: vehicle),
          DividerPersonalizated(thicknessSize: 1),
          //formulario con la data de repostaje
          RefuelingDetailCard(refueling: refueling),
        ],
      ),
    );
  }
}
