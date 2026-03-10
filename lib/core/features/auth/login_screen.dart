import 'package:flutter/material.dart';
import 'package:fuel_smart/core/theme/app_theme.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),

                /// LOGO
                Center(
                  child: Image.asset(
                    "assets/images/logoFM.png",
                    width: 80,
                    height: 80,
                  ),
                ),

                SizedBox(height: 50),

                /// TITULO
                Text(
                  'Iniciar sesión',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                SizedBox(height: 10),

                Text(
                  'Introduce tus credenciales.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                SizedBox(height: 30),

                /// EMAIL
                Text(
                  "Dirección de correo electrónico",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                SizedBox(height: 10),
                //formulario para el correo
                FormWidget(
                  icon: Icons.mail_outline_outlined,
                  obscureText: false,
                ),
                //formulario contraseña
                SizedBox(height: 10),

                Text(
                  "Ejemplo: nombre@correo.com",
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                SizedBox(height: 25),

                /// PASSWORD
                Text(
                  "Contraseña",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                SizedBox(height: 10),

                FormWidget(icon: Icons.lock_outline, obscureText: true),
                SizedBox(height: 35),

                /// BOTON
                ButtonAction(
                  text: "Continuar",
                  onPressed: () {
                    MyApp.of(context)?.changeTheme(AppTheme.redTheme());
                  },
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "¿Olvidaste tu contraseña?",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: 45),
                DividerPersonalizated(),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Text(
        'Solicita tu usuario contactando a admin@correo.com',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
