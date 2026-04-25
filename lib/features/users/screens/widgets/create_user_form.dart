import 'package:flutter/material.dart';
import 'package:fuel_smart/features/shared/widgets/form_user.dart';

class CreateUserForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordConfirm;
  final TextInputType? keyboardType;

  const CreateUserForm({
    super.key,
    required this.email,
    required this.password,
    required this.passwordConfirm,

    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 👈 clave
          children: [
            FormUser(
              label: 'Dirección de correo electrónico',
              icon: Icons.email_outlined,
              controller: email,
            ),

            SizedBox(height: 6),

            Text(
              'Ejemplo: nombreapellido@fuelsmart.com',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),

            SizedBox(height: 20),

            FormUser(
              label: 'Contraseña',
              icon: Icons.lock,
              controller: password,
            ),

            SizedBox(height: 16),

            FormUser(
              label: 'Repetir contraseña',
              icon: Icons.lock,
              controller: passwordConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
