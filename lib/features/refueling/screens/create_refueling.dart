import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/features/refueling/widgets/refueling_form.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/widgets/card_vehicle.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:image_picker/image_picker.dart';

class CreateRefueling extends StatefulWidget {
  final Vehicle vehicle;

  const CreateRefueling({super.key, required this.vehicle});

  @override
  State<CreateRefueling> createState() => _CreateRefuelingState();
}

class _CreateRefuelingState extends State<CreateRefueling> {
  XFile? photo;

  final refuelingDate = TextEditingController();
  final totalGallons = TextEditingController();
  final supllierName = TextEditingController();
  final comment = TextEditingController();
  final odometer = TextEditingController();
  final ticketNumber = TextEditingController();
  final totalMoney = TextEditingController();

  Future<void> getImageFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);

    if (picked != null) {
      setState(() {
        photo = picked;
      });
    }
  }

  Future<void> getImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        photo = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 35),
        ),
        title: Text(
          "Registrar consumo caja menor",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardVehicle(vehicle: widget.vehicle),
            const DividerPersonalizated(thicknessSize: 2),
            const SizedBox(height: 10),

            RefuelingForm(),

            const SizedBox(height: 20),

            /// BOTÓN CÁMARA
            IconButton(
              onPressed: getImageFromCamera,
              icon: const Icon(Icons.camera_alt_outlined, size: 80),
            ),

            const Text(
              'Tomar registro fotográfico',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// PREVIEW IMAGEN
            photo == null
                ? const Icon(Icons.image, size: 80)
                : Image.file(
                    File(photo!.path),
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            ButtonAction(
              text: 'ENVIAR REGISTRO',
              onPressed: () {
                //FUNCION PARA ENVIAR TODO
              },
            ),
          ],
        ),
      ),
    );
  }
}
