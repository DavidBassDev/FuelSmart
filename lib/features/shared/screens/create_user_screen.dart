import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/users/screens/widgets/create_user_form.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final email = TextEditingController();
  final idRol = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Crear usuario", style: TextStyle(fontSize: 20)),
            const Icon(Icons.person_add_alt, size: 35),
          ],
        ),
      ),
      body: Column(
        children: [
          const DividerPersonalizated(thicknessSize: 2),
          const SizedBox(height: 10),
          Text('Ingresa los datos para crear el nuevo usuario'),
          const SizedBox(height: 30),
          CreateUserForm(
            email: email,
            password: password,
            passwordConfirm: confirmPassword,
          ),
          const SizedBox(height: 10),
          Text('Asignar vehículo'),
          Text('Centro de operación'),
          const SizedBox(height: 20),
          ButtonAction(text: 'Crear usuario', onPressed: () {}),
        ],
      ),
    );
  }
}
