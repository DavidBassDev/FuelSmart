import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/show_dialog.dart';
import 'package:fuel_smart/features/refueling/models/refueling.dart';
import 'package:fuel_smart/features/refueling/presentation/screens/see_cash_refueling.dart';
import 'package:fuel_smart/features/refueling/data/datasources/refueling_service.dart';
import 'package:fuel_smart/features/refueling/presentation/widgets/refueling_form.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/card_vehicle.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
    final token = context.read<AuthProvider>().token;

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

            RefuelingForm(
              comment: comment,
              odometer: odometer,
              ticketNumber: ticketNumber,
              totalGallons: totalGallons,
              totalMoney: totalMoney,
            ),

            const SizedBox(height: 20),

            // BOTON CAMARA
            IconButton(
              onPressed: getImageFromCamera,
              icon: const Icon(Icons.camera_alt_outlined, size: 80),
            ),

            const Text(
              'Tomar registro fotográfico',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // PREVIEW IMAGEN
            photo == null
                ? Icon(
                    Icons.image,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Image.file(
                            File(photo!.path),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    child: Image.file(
                      File(photo!.path),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(height: 20),
            ButtonAction(
              text: 'ENVIAR REGISTRO',
              onPressed: () async {
                final data = {
                  "vehiculo_id": widget.vehicle.vehicleId,
                  "usuario_id": widget.vehicle.userId,
                  "proveedor_id": "3",
                  "fecha": DateTime.now().toIso8601String(),
                  "galones": double.parse(totalGallons.text),
                  "valor_total": totalMoney.text.isEmpty
                      ? null
                      : double.parse(totalMoney.text),
                  "odometro": odometer.text.isEmpty
                      ? null
                      : int.parse(odometer.text),
                  "numero_soporte": ticketNumber.text.isEmpty
                      ? null
                      : ticketNumber.text,
                  "comentario": comment.text,
                };

                final response = await RefuelingService().createNewRefueling(
                  token!,
                  data,
                  File(photo!.path),
                );
                final refueling = Refueling.fromJson(response);
                await showDialog(
                  context: context,
                  builder: (context) => ShowDialogPersonalizated(
                    text: 'Consumo registrado correctamente',
                  ),
                );
                //LIMPIO FORMULARIO
                cleanForm(
                  refuelingDate,
                  totalGallons,
                  supllierName,
                  comment,
                  odometer,
                  ticketNumber,
                  totalMoney,
                );
                setState(() {
                  photo = null;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeeCashRefueling(
                      refueling: refueling,
                      vehicle: widget.vehicle,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//LIMPIAR FORMULARIO POR SI REGRESA
void cleanForm(
  refuelingDate,
  totalGallons,
  supllierName,
  comment,
  odometer,
  ticketNumber,
  totalMoney,
) {
  refuelingDate.clear();
  totalGallons.clear();
  supllierName.clear();
  comment.clear();
  odometer.clear();
  ticketNumber.clear();
  totalMoney.clear();
}
