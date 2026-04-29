import 'package:flutter/material.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/api/auth_service.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/core/widgets/show_dialog.dart';
import 'package:fuel_smart/core/providers/themee_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
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
                  controller: emailController,
                ),
                //formulario contraseña
                SizedBox(height: 10),

                Text(
                  "Ejemplo: nombre@correo.com",
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                SizedBox(height: 25),

                // PASSWORD
                Text(
                  "Contraseña",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                SizedBox(height: 10),

                FormWidget(
                  icon: Icons.lock_outline,
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 35),

                // BOTON
                ButtonAction(
                  text: "Continuar",
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ShowDialogPersonalizated(
                            text: "Debes llenar ambos campos",
                          );
                        },
                      );
                      return; //para aca si no cumple con el controller
                    }

                    final authService = AuthService();
                    final response = await authService.login(
                      emailController.text,
                      passwordController.text,
                    );
                    if (response == null || response["token"] == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ShowDialogPersonalizated(
                            text: "Credenciales invalidas",
                          );
                        },
                      );
                      return;
                    } else {
                      final User user = User.fromJson(response["usuario"]);
                      final token = (response["token"]);
                      //actualizar datos en provider
                      Provider.of<AuthProvider>(
                        context,
                        listen: false,
                      ).login(token, user);
                    }
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
                SizedBox(height: 15),
                DividerPersonalizated(thicknessSize: 1),
                Text(
                  "Selecciona tu tema favorito",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        themeProvider.changeTheme(AppThemeType.beige);
                      },
                      icon: Icon(
                        Icons.circle_rounded,
                        color: Color(0xFFF1EDE5),
                        size: 50,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        themeProvider.changeTheme(AppThemeType.wine);
                      },
                      icon: Icon(
                        Icons.circle_rounded,
                        color: Color(0xFF552235),
                        size: 50,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30),
                Text(
                  'Solicita tu usuario contactando a admin@correo.com',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
