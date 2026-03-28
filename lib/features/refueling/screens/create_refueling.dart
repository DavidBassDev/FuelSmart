import 'package:flutter/material.dart';
import 'package:fuel_smart/features/refueling/widgets/refueling_form.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/widgets/card_vehicle.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';

class CreateRefueling extends StatelessWidget {
  final Vehicle vehicle;
  const CreateRefueling({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final refuelingDate = TextEditingController();
    final totalGallons = TextEditingController();
    final supllierName = TextEditingController();
    final comment = TextEditingController();
    final totalMoney = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, size: 35),
        ),
        title: Text(
          "Registrar consumo caja menor",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
      body: Column(
        children: [
          CardVehicle(vehicle: vehicle),
          DividerPersonalizated(thicknessSize: 2),
          SizedBox(height: 10),
          RefuelingForm(),
          SizedBox(height: 20),
          IconButton(
            onPressed: () {
              //funcion para abrir la camara
            },
            icon: Icon(Icons.camera_alt_outlined, size: 80),
          ),
          Text(
            'Tomar registro fotográfico',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
