import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/presentation/screens/see_refuelings_vehicle_screen.dart';
import 'package:fuel_smart/features/refueling/data/datasources/refueling_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/data/datasources/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/admin_card_vehicle.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/fuel_circle.dart';
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
  bool statusVehicle = true;
  IconData activityVehicle = Icons.pause;
  String actionStatusVehicle = 'Suspender vehículo';

  Vehicle? vehicle;
  double totalGallons = 0.0;

  @override
  void initState() {
    super.initState();
    loadVehicle(widget.vehicleSelected);
  }

  Future<void> loadVehicle(int vehicleSelected) async {
    try {
      final response = await vehicleService.getVehicle(vehicleSelected);

      if (!mounted) return;

      setState(() {
        vehicle = response;
      });

      await getGallonsConsumed();

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error cargando vehículo: $e");

      if (!mounted) return;

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

      if (!mounted) return;

      setState(() {
        totalGallons =
            double.tryParse(response['data']['total_galones'].toString()) ??
            0.0;
      });
    } catch (e) {
      print("Error cargando consumos del vehículo: $e");
    }
  }

  Future<void> handleToggleVehicle() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    final isActive = vehicle!.state;

    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isActive ? "Inactivar vehículo" : "Activar vehículo"),
        content: Text(
          isActive
              ? "¿Seguro que deseas inactivarlo?"
              : "¿Seguro que deseas activarlo?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      if (isActive) {
        await vehicleService.inactivateVehicle(auth.token!, vehicle!.vehicleId);
      } else {
        await vehicleService.activateVehicle(auth.token!, vehicle!.vehicleId);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isActive ? "Vehículo inactivado" : "Vehículo activado"),
        ),
      );

      setState(() {
        isLoading = true;
      });

      await loadVehicle(widget.vehicleSelected);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
    if (statusVehicle == false) {
      activityVehicle = Icons.play_arrow;
      actionStatusVehicle = 'Activar vehiculo';
    } else {
      activityVehicle = Icons.pause;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        title: Text(
          "Administrar vehículo ${vehicle!.plate}",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DividerPersonalizated(thicknessSize: 1),
              AdminCardVehicle(vehicle: vehicle!),

              const SizedBox(height: 30),

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
                                vehicleId: widget.vehicleSelected,
                                vehicle: vehicle!,
                                totalGallons: totalGallons,
                              ),
                            ),
                          );
                        },
                      ),
                      const Text("Ver rendimiento y consumos"),
                    ],
                  ),

                  const SizedBox(width: 30),

                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          vehicle!.state ? Icons.pause : Icons.play_arrow,
                          color: Theme.of(context).colorScheme.primary,
                          size: 30,
                        ),
                        onPressed: handleToggleVehicle, // 🔥 SIEMPRE activo
                      ),
                      Text(
                        vehicle!.state
                            ? 'Suspender vehículo'
                            : 'Activar vehículo',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),
              DividerPersonalizated(thicknessSize: 1),

              SizedBox(
                height: 320,
                child: FuelCircleWidget(
                  totalGallons: totalGallons,
                  availableFuel: vehicle!.avaliableFuel,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
