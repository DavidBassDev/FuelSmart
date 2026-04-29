import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/models/clients.dart';
import 'package:fuel_smart/features/refueling/models/vehicle_gallons.dart';
import 'package:fuel_smart/features/refueling/services/refueling_service.dart';

class AdminClientScreen extends StatefulWidget {
  final Clients clientSelected;

  const AdminClientScreen({super.key, required this.clientSelected});

  @override
  State<AdminClientScreen> createState() => _AdminClientScreenState();
}

class _AdminClientScreenState extends State<AdminClientScreen> {
  final RefuelingService refuelingService = RefuelingService();

  bool isLoading = true;

  List<VehicleGallons> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final token = authProvider.token;

      final response = await refuelingService.getVehiclesWithGallonsByClient(
        token!,
        widget.clientSelected.clientId!,
        4, // abril
      );

      final List data = response['data'];

      setState(() {
        vehicles = data.map((item) => VehicleGallons.fromJson(item)).toList();

        isLoading = false;
      });
    } catch (e) {
      print("Error cargando vehículos: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('llego el cliente ${widget.clientSelected.name}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        title: Text(
          "Administrar vehículos cliente ${widget.clientSelected.name}",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
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
                        title: Text(vehicle.placa),
                        subtitle: Text(
                          "Galones consumidos: ${vehicle.totalGalones}",
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
                            // acción futura
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
