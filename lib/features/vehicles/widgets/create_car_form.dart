import 'package:flutter/material.dart';
import 'package:fuel_smart/features/shared/widgets/form_user.dart';
import 'package:fuel_smart/features/vehicles/widgets/form_car.dart';

class CreateCarForm extends StatelessWidget {
  final TextEditingController plate;
  final TextEditingController vehicleType;
  final TextEditingController teoricPerformance;
  final TextEditingController? fuelSupplier;
  final TextEditingController clientId;
  final TextEditingController userId;
  final TextInputType? keyboardType;

  const CreateCarForm({
    super.key,
    required this.plate,
    this.keyboardType,
    required this.vehicleType,
    required this.teoricPerformance,
    this.fuelSupplier,
    required this.clientId,
    required this.userId,
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
              label: 'Nombre completo',
              icon: Icons.assignment_ind_outlined,
              controller: fullName,
              obscureText: false,
            ),

            SizedBox(height: 6),
            FormUser(
              label: 'Dirección de correo electrónico',
              icon: Icons.email_outlined,
              controller: email,
              obscureText: false,
            ),

            SizedBox(height: 6),

            Text(
              'Ejemplo: nombreapellido@fuelsmart.com',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),

            SizedBox(height: 20),

            FormCar(
              label: 'Contraseña',
              icon: Icons.lock,
              controller: password,
              obscureText: true,
            ),

            SizedBox(height: 16),

            FormCar(
              label: 'Repetir contraseña',
              icon: Icons.lock,
              controller: passwordConfirm,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
