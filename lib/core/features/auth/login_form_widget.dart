import 'package:flutter/material.dart';

//widget para login, lo guardo aca y no en widgets porque solo se usa en una pantalla
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Iniciar sesión',
          style: Theme.of(context).textTheme.headlineMedium,
        ),

        const SizedBox(height: 4),

        Text(
          'Introduce tus credenciales.',
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 4),

        /// EMAIL
        Text(
          "Dirección de correo electrónico",
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        const SizedBox(height: 2),

        TextFormField(
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.mail_outline, color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "Ejemplo: nombre@correo.com",
          style: Theme.of(context).textTheme.bodySmall,
        ),

        const SizedBox(height: 15),

        /// PASSWORD
        Text("Contraseña", style: Theme.of(context).textTheme.bodyLarge),

        const SizedBox(height: 2),

        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.lock_outline, color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),

        const SizedBox(height: 40),

        /// BOTON
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF552235),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {},
            child: const Text(
              "Continuar",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
