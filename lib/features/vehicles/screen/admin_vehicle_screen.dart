import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/screens/see_refuelings_vehicle_screen.dart';
import 'package:fuel_smart/features/refueling/services/refueling_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/widgets/admin_card_vehicle.dart';
import 'package:fuel_smart/features/vehicles/widgets/fuel_circle.dart';
import 'package:provider/provider.dart';

class AdminVehicleScreen extends StatefulWidget {
  final int vehicleSelected;

  const AdminVehicleScreen({super.key, required this.vehicleSelected});

  @override
  State<AdminVehicleScreen> createState() => _AdminVehicleScreenState();
}

class _AdminVehicleScreenState extends State<AdminVehicleScreen> {
  final VehicleService vehicleService = VehicleService();
  final RefuelingService refuelingService = RefuelingService();

  bool isLoading = true;

  Vehicle? vehicle;
  double totalGallons = 0.0;

  @override
  void initState() {
    super.initState();
    loadVehicle(widget.vehicleSelected);
    print('recibo el vehiculo ${widget.vehicleSelected}');
  }

  Future<void> loadVehicle(int vehicleSelected) async {
    try {
      final response = await vehicleService.getVehicle(vehicleSelected);

      setState(() {
        vehicle = response;
      });
      //ESPERAR QUE TRAIGA LOS GALONES
      await getGallonsConsumed();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error cargando vehículo: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  // Cargar consumos del vehículo
  Future<void> getGallonsConsumed() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final token = authProvider.token;

      if (token == null) return;

      final int currentMonth = DateTime.now().month;

      final response = await refuelingService.getGallonsConsumed(
        token,
        widget.vehicleSelected,
        currentMonth,
      );

      setState(() {
        totalGallons =
            double.tryParse(response['data']['total_galones'].toString()) ??
            0.0;
      });

      print("TOTAL GALONES: $totalGallons");
    } catch (e) {
      print("Error cargando consumos del vehículo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (vehicle == null) {
      return const Scaffold(
        body: Center(child: Text("No se pudo cargar el vehículo")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            "Administrar vehículo ${vehicle!.plate}",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerPersonalizated(thicknessSize: 1),
              AdminCardVehicle(vehicle: vehicle!),
              SizedBox(height: 30),
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SeeRefuelingsVehicleScreen(
                                vehicle: vehicle!,
                                totalGallons: totalGallons,
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        "Ver rendimiento y consumos",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.pause,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        onPressed: () {
                          print('funca');
                        },
                      ),
                      Text(
                        "Suspender vehículo",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              DividerPersonalizated(thicknessSize: 1),
              SizedBox(
                height: 320,
                child: FuelCircleWidget(
                  totalGallons: totalGallons,
                  availableFuel: vehicle!.avaliableFuel,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Aumentar cupo'),
                  IconButton(
                    icon: Icon(Icons.add, size: 30),
                    onPressed: () {
                      print('funca');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
