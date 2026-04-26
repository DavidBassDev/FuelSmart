import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/models/client.dart';
import 'package:fuel_smart/features/fuelSupplier/models/fuel_supplier.dart';
import 'package:fuel_smart/features/fuelSupplier/services/fuel_supplier_service.dart';
import 'package:fuel_smart/features/refueling/models/supplier_fuel.dart';
import 'package:fuel_smart/features/shared/services/client_service.dart';
import 'package:fuel_smart/features/shared/services/vehicle_type_service.dart';
import 'package:fuel_smart/features/shared/widgets/card_new_car.dart';
import 'package:fuel_smart/features/shared/widgets/drop_list.dart';
import 'package:fuel_smart/features/vehicles/models/type_of_vehicle.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/widgets/create_car_form.dart';
import 'package:provider/provider.dart';

class CreateVehicleScreen extends StatefulWidget {
  const CreateVehicleScreen({super.key});

  @override
  State<CreateVehicleScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateVehicleScreen> {
  final plate = TextEditingController();
  final typeVehicle = TextEditingController();
  final teoricPerformance = TextEditingController();
  final fuelSupplier = TextEditingController();
  final client = TextEditingController();
  final user = TextEditingController();
  final FuelSupplierService fuelSupplierService = FuelSupplierService();
  final ClientService clientService = ClientService();
  final VehicleService vehicleService = VehicleService();
  final VehicleTypeService vehicleTypeService = VehicleTypeService();
  String placaPreview = '';
  double rendimientoPreview = 0;
  String tipoVehiculoPreview = '';

  //cargar los datos

  List<SupplierFuel> supplierFuel = [];

  List<Client> clients = [];
  Client? selectedClient;

  List<Vehicle> vehicles = [];
  Vehicle? vehicleSelected;

  List<TypeOfVehicle> typeOfVehicle = [];
  TypeOfVehicle? typeOfVehicleSelected;

  List<FuelSupplier> suppliers = [];
  FuelSupplier? supplierFuelSelected;

  @override
  void initState() {
    super.initState();
    loadSupplierFuel();
    loadClients();
    listVehicleType();
    plate.addListener(() {
      actualizarPreview();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final auth = Provider.of<AuthProvider>(context);

    if (auth.token != null) {
      loadVehicles(auth.token!);
    }
  }

  //cargar lista de proveedores combustible
  Future<void> loadSupplierFuel() async {
    final auth = context.read<AuthProvider>();
    final token = auth.token ?? 'sin token';
    final data = await fuelSupplierService.getFuelSupplier(token);

    setState(() {
      suppliers = data;
      supplierFuelSelected = data.isNotEmpty ? data[0] : null;
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

  //listar tipos de vehiculos
  Future<void> listVehicleType() async {
    final data = await vehicleTypeService.getList();
    setState(() {
      typeOfVehicle = data;
    });
  }

  //actualizar preview
  void actualizarPreview() {
    setState(() {
      placaPreview = plate.text;

      // puedes cambiar esto luego por lógica real/API
      if (plate.text.isNotEmpty) {
        rendimientoPreview = 30; // temporal
        tipoVehiculoPreview = typeOfVehicleSelected?.name ?? '';
      } else {
        rendimientoPreview = 0;
        tipoVehiculoPreview = '';
      }
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
            Text("Crear Vehículo", style: TextStyle(fontSize: 20)),
            const Icon(Icons.person_add_alt, size: 35),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DividerPersonalizated(thicknessSize: 1),
            CardNewCar(
              centroOperacion: selectedClient?.name ?? '',
              placa: placaPreview,
              rendimientoTeorico: rendimientoPreview,
              tipoVehiculo: tipoVehiculoPreview,
              usuario: 'test',
            ),
            const DividerPersonalizated(thicknessSize: 2),
            const SizedBox(height: 10),
            Text('Ingresa los datos para crear el nuevo vehículo'),
            const SizedBox(height: 20),
            CreateCarForm(
              plate: plate,
              teoricPerformance: teoricPerformance,
              onPlateChanged: (value) {
                setState(() {
                  placaPreview = value;
                });
              },
              onPerformanceChanged: (value) {
                setState(() {
                  rendimientoPreview = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 30),

            DropList<TypeOfVehicle>(
              label: "Asignar tipo de vehículo",
              hint: "Selecciona una tipología",
              items: typeOfVehicle,
              value: typeOfVehicleSelected,
              itemLabel: (typeOfVehicle) => typeOfVehicle.name,
              onChanged: (value) {
                setState(() {
                  typeOfVehicleSelected = value;
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
            const SizedBox(height: 30),
            DropList<FuelSupplier>(
              label: "Proveedor combustible",
              hint: "Selecciona un proveedor",
              items: suppliers,
              value: supplierFuelSelected,
              itemLabel: (suppliers) => suppliers.nameFuelSupplier,
              onChanged: (value) {
                setState(() {
                  supplierFuelSelected = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ButtonAction(
              text: 'Crear vehiculo',
              onPressed: () async {
                /*
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
                  /*var data = await userService.createUser(token!, {
                    "nombre_completo": fullName.text,
                    "correo_electronico": email.text,
                    "password": password.text,
                    "rol_id": selectedRole?.rolId,
                    "creado_por":
                        auth.user!.id, //traer id del usuario que esta creando
                    "cliente": selectedClient?.clientId,
                    "id_vehiculo": vehicleSelected?.vehicleId,
                  });*/

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Usuario actualizado")),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al actualizar")),
                  );
                }*/
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
