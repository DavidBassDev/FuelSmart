import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});

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
          //CREAR WIDGET PERSONALIZADO, PARA ESTE FORMULARIO
        ],
      ),
    );
  }
}
