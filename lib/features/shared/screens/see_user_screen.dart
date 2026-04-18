import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFF8B3A4A),
      appBar: AppBar(title: const Text("Administrar usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }
}
