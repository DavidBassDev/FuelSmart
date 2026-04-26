import 'package:flutter/material.dart';
import 'package:fuel_smart/features/vehicles/widgets/form_car.dart';

class CreateCarForm extends StatelessWidget {
  final TextEditingController plate;
  final TextEditingController teoricPerformance;
  final TextInputType? keyboardType;
  final Function(String)? onPlateChanged;
  final Function(String)? onPerformanceChanged;

  const CreateCarForm({
    super.key,
    required this.plate,
    required this.teoricPerformance,
    this.keyboardType,
    this.onPlateChanged,
    this.onPerformanceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormCar(
              label: 'Placa',
              icon: Icons.credit_card,
              controller: plate,
              onChanged: onPlateChanged,
            ),

            SizedBox(height: 6),

            FormCar(
              label: 'Rendimiento teórico',
              icon: Icons.local_gas_station_outlined,
              controller: teoricPerformance,
              onChanged: onPerformanceChanged,
            ),
          ],
        ),
      ),
    );
  }
}
