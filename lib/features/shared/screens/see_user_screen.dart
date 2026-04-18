import 'package:flutter/material.dart';
import 'package:fuel_smart/features/shared/services/RoleService.dart';
import 'package:fuel_smart/features/shared/widgets/drop_list.dart';

class SeeUserScreen extends StatefulWidget {
  const SeeUserScreen({super.key});

  @override
  State<SeeUserScreen> createState() => _SeeUserScreenState();
}

class _SeeUserScreenState extends State<SeeUserScreen> {
  final RoleService roleService = RoleService();

  List roles = [];
  dynamic selectedRole;

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
      backgroundColor: const Color(0xFF8B3A4A), // tu color
      appBar: AppBar(title: const Text("Administrar usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropList(
              label: "Rol de Usuario",
              hint: "Selecciona un rol",
              items: roles,
              value: selectedRole,
              itemLabel: (rol) => rol.toString(),
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
