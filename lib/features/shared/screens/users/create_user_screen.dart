import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/models/client.dart';
import 'package:fuel_smart/features/shared/services/client_service.dart';
import 'package:fuel_smart/features/shared/services/role_service.dart';
import 'package:fuel_smart/features/shared/widgets/drop_list.dart';
import 'package:fuel_smart/features/users/models/user_rol.dart';
import 'package:fuel_smart/features/users/screens/widgets/create_user_form.dart';
import 'package:fuel_smart/features/users/services/user_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
import 'package:provider/provider.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final idRol = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final RoleService roleService = RoleService();
  final ClientService clientService = ClientService();
  final VehicleService vehicleService = VehicleService();
  final UserService userService = UserService();

  //cargar los datos

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
    final token = context.read<AuthProvider>().token;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DividerPersonalizated(thicknessSize: 2),
            const SizedBox(height: 10),
            Text('Ingresa los datos para crear el nuevo usuario'),
            const SizedBox(height: 30),
            CreateUserForm(
              fullName: fullName,
              email: email,
              password: password,
              passwordConfirm: confirmPassword,
            ),
            const SizedBox(height: 30),

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
            const SizedBox(height: 30),
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
            ButtonAction(
              text: 'Crear usuario',
              onPressed: () async {
                final auth = context.read<AuthProvider>();
                //crear usuario funcion
                //VALIDAR SI AMBAS CONTRASEÑAS COINCIDEN

                try {
                  if (password.text != confirmPassword.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Las contraseñas no coinciden"),
                      ),
                    );
                    return; //detengo ejecucion
                  }
                  var data = await userService.createUser(token!, {
                    "nombre_completo": fullName.text,
                    "correo_electronico": email.text,
                    "password": password.text,
                    "rol_id": selectedRole?.rolId,
                    "creado_por":
                        auth.user!.id, //traer id del usuario que esta creando
                    "cliente": selectedClient?.clientId,
                    "id_vehiculo": vehicleSelected?.vehicleId,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Usuario actualizado")),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al actualizar")),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<bool> passwordMatch(password, password2) async {
    bool match = false;
    if (password == password2) {
      match = true;
    }
    return match;
  }
}
