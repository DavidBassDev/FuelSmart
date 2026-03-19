import 'package:flutter/material.dart';
import 'package:fuel_smart/core/features/vehicles/services/vehicle_service.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';

class RefuelingScreen extends StatefulWidget {
  final String token;

  const RefuelingScreen({super.key, required this.token});

  @override
  State<RefuelingScreen> createState() => _RefuelingScreenState();
}

class _RefuelingScreenState extends State<RefuelingScreen> {
  List<Map<String, dynamic>> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future loadVehicles() async {
    final vehicleService = VehicleService();

    final response = await vehicleService.getMyVehicles(widget.token);

    setState(() {
      vehicles = (response as List)
          .map((vehicle) => Map<String, dynamic>.from(vehicle))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: Text(
          "Registrar consumo caja menor",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const DividerPersonalizated(thicknessSize: 1),
          const Icon(Icons.directions_car, size: 110),
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
            child: vehicles.isEmpty
                ? const Center(child: Text("No hay vehículos disponibles"))
                : ListView.separated(
                    itemCount: vehicles.length,
                    separatorBuilder: (context, index) {
                      return const DividerPersonalizated(thicknessSize: 1);
                    },
                    itemBuilder: (context, index) {
                      final vehicle = vehicles[index];

                      return ListTile(
                        leading: const Icon(Icons.directions_car, size: 50),
                        title: Text(vehicle["placa"] ?? ""),
                        subtitle: Text(
                          "Rendimiento: ${vehicle["rendimiento_teorico"] ?? ""}",
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            backgroundColor: const Color(0xFF5C1F2B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            print("Vehículo seleccionado: ${vehicle["placa"]}");
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
