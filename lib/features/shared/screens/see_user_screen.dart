import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/features/shared/services/RoleService.dart';
import 'package:fuel_smart/features/shared/widgets/drop_list.dart';
import 'package:fuel_smart/features/users/models/user_rol.dart';

class SeeUserScreen extends StatefulWidget {
  const SeeUserScreen({super.key});

  @override
  State<SeeUserScreen> createState() => _SeeUserScreenState();
}

class _SeeUserScreenState extends State<SeeUserScreen> {
  final RoleService roleService = RoleService();
  final emailController = TextEditingController();

  List<UserRol> roles = [];
  UserRol? selectedRole;

  @override
  void initState() {
    super.initState();
    loadRoles();
  }

  Future<void> loadRoles() async {
    final data = await roleService.getRoles();
    setState(() {
      roles = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF883955),
      appBar: AppBar(
        title: const Text("Administrar usuario"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('NOMBRE USUARIO'), Text('ROL'), Text('CLIENTE')],
            ),
            SizedBox(height: 30),
            DividerPersonalizated(thicknessSize: 1),
            SizedBox(height: 20),
            Text(
              "Dirección de correo electrónico",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 10),
            //correo
            FormWidget(
              icon: Icons.mail_outline_outlined,
              obscureText: false,
              controller: emailController,
              hint: 'correo@fuelsmart.com',
            ),
            SizedBox(height: 30),
            //Seleccionar Rol
            DropList<UserRol>(
              label: "Rol de Usuario",
              hint: "Selecciona un rol",
              items: roles,
              value: selectedRole,
              itemLabel: (rol) => rol.rolName,
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            SizedBox(height: 20),

            DropList<UserRol>(
              label: "Centro de operación",
              hint: "Selecciona un cliente",
              items: roles,
              value: selectedRole,
              itemLabel: (rol) => rol.rolName,
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropList<UserRol>(
              label: "Asignar vehículo",
              hint: "PLACA ACTUAL",
              items: roles,
              value: selectedRole,
              itemLabel: (rol) => rol.rolName,
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
            SizedBox(height: 20),
            ButtonAction(text: 'Editar usuario', onPressed: () {}),
            SizedBox(height: 40),
            ButtonAction(text: 'Eliminar Usuario', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
