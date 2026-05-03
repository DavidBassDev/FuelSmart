import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/data/models/client_model.dart';
import 'package:fuel_smart/features/fuelsupplier/data/models/fuel_supplier.dart';
import 'package:fuel_smart/features/fuelsupplier/data/datasources/fuel_supplier_service.dart';
import 'package:fuel_smart/features/refueling/models/supplier_fuel.dart';
import 'package:fuel_smart/features/clients/data/datasources/client_service.dart';
import 'package:fuel_smart/features/vehicles/data/datasources/vehicle_type_service.dart';
import 'package:fuel_smart/features/shared/presentation/widgets/card_new_car.dart';
import 'package:fuel_smart/features/shared/presentation/widgets/drop_list.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/users/data/datasources/user_service.dart';
import 'package:fuel_smart/features/vehicles/models/type_of_vehicle.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/data/datasources/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/create_car_form.dart';
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
  final UserService userService = UserService();
  String placaPreview = '';
  double rendimientoPreview = 0;
  String tipoVehiculoPreview = '';
  String userPreview = '';

  //cargar los datos

  List<SupplierFuel> supplierFuel = [];

  List<Clients> clients = [];
  Clients? selectedClient;

  List<Vehicle> vehicles = [];
  Vehicle? vehicleSelected;

  List<TypeOfVehicle> typeOfVehicle = [];
  TypeOfVehicle? typeOfVehicleSelected;

  List<FuelSupplier> suppliers = [];
  FuelSupplier? supplierFuelSelected;

  List<User> users = [];
  User? userSelected;

  @override
  void initState() {
    super.initState();
    loadSupplierFuel();
    loadClients();
    listVehicleType();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final auth = Provider.of<AuthProvider>(context);

    if (auth.token != null) {
      loadVehicles(auth.token!);
      listAllUsers(auth.token!);
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

  //LISTAR LOS USUARIOS CREADOS
  Future<void> listAllUsers(String token) async {
    final data = await userService.getAllUsers(token);
    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthProvider>().token;
    DateTime now = DateTime.now();
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
            SizedBox(height: 20),
            CardNewCar(
              centroOperacion: selectedClient?.name ?? '',
              placa: placaPreview,
              rendimientoTeorico: rendimientoPreview,
              tipoVehiculo: tipoVehiculoPreview,
              usuario: userPreview,
            ),
            const SizedBox(height: 5),
            const DividerPersonalizated(thicknessSize: 2),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              'Ingresa los datos para crear el nuevo vehículo',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
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
                  tipoVehiculoPreview = value?.name ?? '';
                });
              },
            ),
            const SizedBox(height: 30),
            DropList<Clients>(
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
            //Asignar usuario del conductor
            const SizedBox(height: 20),
            DropList<User>(
              label: "Asigna usuario al vehiculo",
              hint: "Seleccionar usuario",
              items: users,
              value: userSelected,
              itemLabel: (users) => users.nombre,
              onChanged: (value) {
                setState(() {
                  userSelected = value;
                  userPreview = value?.nombre ?? '';
                });
              },
            ),

            const SizedBox(height: 20),
            ButtonAction(
              text: 'Crear vehiculo',
              onPressed: () async {
                final auth = context.read<AuthProvider>();
                //crear usuario funcion
                //VALIDAR SI FORMULARIO ESTA BIEN
                try {
                  if (plate.text.isEmpty ||
                      teoricPerformance.text.isEmpty ||
                      selectedClient == null ||
                      typeOfVehicleSelected == null ||
                      userSelected == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Debes llenar todos los datos"),
                      ),
                    );
                    return; //detengo ejecucion
                  }
                  var data = await vehicleService.createVehicle(token!, {
                    "usuario_id": userSelected?.id,
                    "placa": plate.text,
                    "rendimiento_teorico": teoricPerformance.text,
                    "rentimiento": 0.0,
                    "cupo_combustible": 72.0,
                    "estado": true,
                    "fecha_creacion": now.toIso8601String(),
                    "fecha_actualizacion": null,
                    "creado_por": auth.user!.id,
                    "id_tipo_vehiculo":
                        typeOfVehicleSelected?.typeOfVehicleId ?? 2,
                    "id_proveedor": supplierFuelSelected?.idFuelSupplier,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vehiculo creado")),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Error al crear vehiculo")),
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
}
