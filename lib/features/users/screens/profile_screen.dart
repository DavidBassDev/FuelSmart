import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/features/users/services/user_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final newPassword = TextEditingController();
  final newPassword2 = TextEditingController();

  @override
  void dispose() {
    newPassword.dispose();
    newPassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user!;
    final token = auth.token;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 35),
        ),
        title: Text("Mi perfil - ${user.nombre}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Icon(Icons.person, size: 120)),
            const SizedBox(height: 70),

            const Text('Nueva contraseña'),
            const SizedBox(height: 10),
            FormWidget(
              controller: newPassword,
              icon: Icons.lock_outline,
              obscureText: true,
            ),

            const SizedBox(height: 60),

            const Text('Repetir contraseña'),
            const SizedBox(height: 10),
            FormWidget(
              controller: newPassword2,
              icon: Icons.lock_outline,
              obscureText: true,
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 30),

            ButtonAction(
              text: 'Guardar cambios',
              onPressed: () async {
                if (!validatePassword(newPassword.text, newPassword2.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Las contraseñas no coinciden"),
                    ),
                  );
                  return;
                }

                if (newPassword.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("La contraseña no puede estar vacía"),
                    ),
                  );
                  return;
                }

                final data = {"password": newPassword.value.text};
                print("password ${newPassword.value.text}");

                try {
                  final response = await UserService().changePassword(
                    token!,
                    data,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Contraseña actualizada")),
                  );

                  print(response);
                } catch (e) {
                  print('error $e');
                }
              },
            ),
            const SizedBox(height: 60),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  //cerrar sesion

                  final result = await showYesNoDialog(context);

                  if (result == true) {
                    context.read<AuthProvider>().logout();
                  }
                },

                child: Text(
                  'Cerrar Sesión',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool validatePassword(String password1, String password2) {
  if (password1 == password2) {
    return true;
  } else {
    return false;
  }
}

Future<bool?> showYesNoDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Confirmar"),
        content: Text("¿Seguro que deseas cerrar sesión?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("No", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Sí", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
