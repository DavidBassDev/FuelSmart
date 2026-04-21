import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/features/clients/models/client.dart';
import 'package:fuel_smart/features/shared/services/client_service.dart';
import 'package:fuel_smart/features/shared/services/role_service.dart';
import 'package:fuel_smart/features/shared/widgets/drop_list.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/users/models/user_rol.dart';
import 'package:fuel_smart/features/users/services/user_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
import 'package:provider/provider.dart';

class SeeUserScreen extends StatefulWidget {
  final User userSelected;
  const SeeUserScreen({super.key, required this.userSelected});

  @override
  State<SeeUserScreen> createState() => _SeeUserScreenState();
}

class _SeeUserScreenState extends State<SeeUserScreen> {
  final RoleService roleService = RoleService();
  final ClientService clientService = ClientService();
  final VehicleService vehicleService = VehicleService();
  final UserService userService = UserService();

  final emailController = TextEditingController();

  List<UserRol> roles = [];
  UserRol? selectedRole;

  List<Client> clients = [];
  Client? selectedClient;

  List<Vehicle> vehicles = [];
  Vehicle? vehicleSelected;

  @override
  void initState() {
    super.initState();
    loadRoles();
    loadClients();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final auth = Provider.of<AuthProvider>(context);

    if (auth.token != null) {
      loadVehicles(auth.token!);
    }
  }

  Future<void> loadRoles() async {
    final data = await roleService.getRoles();
    setState(() {
      roles = data;
    });
  }

  Future<void> loadClients() async {
    final data = await clientService.getClient();
    setState(() {
      clients = data;
    });
  }

  Future<void> loadVehicles(String token) async {
    final data = await vehicleService.getVehicles();
    setState(() {
      vehicles = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLogged || auth.user == null || auth.token == null) {
      return const Scaffold(body: Center(child: Text("Token inválido")));
    }

    final User user = auth.user!;
    final name = auth.token!;

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
              children: [
                Text(widget.userSelected.nombre),
                Text(widget.userSelected.rol!),
                Text(widget.userSelected.nombreProyecto ?? 'Sede Principal'),
              ],
            ),
            const SizedBox(height: 30),
            DividerPersonalizated(thicknessSize: 1),
            const SizedBox(height: 20),

            Text(
              "Dirección de correo electrónico",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),

            FormWidget(
              icon: Icons.mail_outline_outlined,
              obscureText: false,
              controller: emailController,
              hint: 'correo@fuelsmart.com',
            ),

            const SizedBox(height: 30),

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

            const SizedBox(height: 20),

            DropList<Client>(
              label: "Centro de operación",
              hint: "Selecciona un cliente",
              items: clients,
              value: selectedClient,
              itemLabel: (client) => client.name,
              onChanged: (value) {
                setState(() {
                  selectedClient = value;
                });
              },
            ),

            const SizedBox(height: 20),

            DropList<Vehicle>(
              label: "Asignar vehículo",
              hint: "Selecciona un vehículo",
              items: vehicles,
              value: vehicleSelected,
              itemLabel: (vehicle) => vehicle.plate,
              onChanged: (value) {
                setState(() {
                  vehicleSelected = value;
                });
              },
            ),

            const SizedBox(height: 20),

            ButtonAction(
              text: 'Editar usuario',
              onPressed: () async {
                try {
                  var data = await userService.updateUser(auth.token!, {
                    "id_usuario": widget.userSelected.id,
                    "rol_id": selectedRole?.rolId,
                    "cliente_id": selectedClient?.clientId,
                    "id_vehiculo": vehicleSelected?.vehicleId,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Usuario actualizado")),
                  );
                } catch (e) {
                  print(e);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al actualizar")),
                  );
                }
              },
            ),
            const SizedBox(height: 40),
            ButtonAction(text: 'Eliminar Usuario', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
