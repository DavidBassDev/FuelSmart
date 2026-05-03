import 'package:flutter/material.dart';
import 'package:fuel_smart/features/refueling/presentation/screens/create_refueling.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/vehicles/data/datasources/vehicle_service.dart';
import 'package:provider/provider.dart';

class RefuelingScreen extends StatefulWidget {
  const RefuelingScreen({super.key});

  @override
  State<RefuelingScreen> createState() => _RefuelingScreenState();
}

class _RefuelingScreenState extends State<RefuelingScreen> {
  List<Vehicle> vehicles = [];
  bool isLoading = true;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      loadVehicles();
      _loaded = true;
    }
  }

  Future<void> loadVehicles() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final vehicleService = VehicleService();
    final response = await vehicleService.getMyVehicles(auth.token!);

    if (!mounted) return;

    setState(() {
      vehicles = (response as List).map((v) => Vehicle.fromJson(v)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registrar consumo caja menor",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const DividerPersonalizated(thicknessSize: 1),
          Icon(
            Icons.directions_car,
            size: 110,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 30),

          Text(
            "Selecciona uno de tus vehículos",
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 25),
          const DividerPersonalizated(thicknessSize: 1),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : vehicles.isEmpty
                ? const Center(child: Text("No hay vehículos disponibles"))
                : ListView.separated(
                    itemCount: vehicles.length,
                    separatorBuilder: (_, __) =>
                        const DividerPersonalizated(thicknessSize: 1),
                    itemBuilder: (context, index) {
                      final vehicle = vehicles[index];

                      return ListTile(
                        leading: const Icon(Icons.directions_car, size: 50),
                        title: Text(vehicle.plate),
                        subtitle: Text(
                          "Rendimiento Teórico: ${vehicle.teoricPerformance}",
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CreateRefueling(vehicle: vehicle),
                              ),
                            );
                          },
                          child: const Text("Seleccionar"),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
