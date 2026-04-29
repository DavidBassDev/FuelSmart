import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/widgets/admin_card_vehicle.dart';
import 'package:provider/provider.dart';

class AdminVehicleScreen extends StatefulWidget {
  final int vehicleSelected;

  const AdminVehicleScreen({super.key, required this.vehicleSelected});

  @override
  State<AdminVehicleScreen> createState() => _AdminVehicleScreenState();
}

class _AdminVehicleScreenState extends State<AdminVehicleScreen> {
  final VehicleService vehicleService = VehicleService();

  bool isLoading = true;

  Vehicle? vehicle;

  @override
  void initState() {
    super.initState();
    loadVehicle(widget.vehicleSelected);
  }

  Future<void> loadVehicle(int vehicleSelected) async {
    try {
      Provider.of<AuthProvider>(context, listen: false);

      final response = await vehicleService.getVehicle(vehicleSelected);

      setState(() {
        vehicle = response;
        isLoading = false;
      });
    } catch (e) {
      print("Error cargando vehículo: $e");

      setState(() {
        isLoading = false;
      });
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
        title: Text(
          "Administrar vehículo ${vehicle!.plate}",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
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
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
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
                    Icon(
                      Icons.pause,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
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
          ],
        ),
      ),
    );
  }
}
