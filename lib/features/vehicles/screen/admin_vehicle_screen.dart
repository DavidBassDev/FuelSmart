import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
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
            Text("Placa: ${vehicle!.plate}"),
            Text("Conductor: ${vehicle!.userName}"),
            Text("Tipo: ${vehicle!.typeOfVehicle}"),
            Text("Cupo combustible: ${vehicle!.avaliableFuel}"),
            Text("Rendimiento teórico: ${vehicle!.teoricPerformance}"),
            Text("Estado: ${vehicle!.state ? "Activo" : "Inactivo"}"),
          ],
        ),
      ),
    );
  }
}
