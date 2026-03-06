import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/logoFM.png",
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Iniciar sesión',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            Text(
              'Introduce tus credenciales.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// EMAIL
                Text(
                  "Dirección de correo electrónico",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Ejemplo: nombre@correo.com",
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                const SizedBox(height: 30),

                /// PASSWORD
                Text(
                  "Contraseña",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 8),

                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// BOTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF552235),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      print("dio click");
                    },
                    child: Text(
                      "Continuar",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
