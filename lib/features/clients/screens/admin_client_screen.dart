import 'package:flutter/material.dart';
import 'package:fuel_smart/features/vehicles/screen/admin_vehicle_screen.dart';
import 'package:provider/provider.dart';

import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/models/clients.dart';
import 'package:fuel_smart/features/refueling/models/vehicle_gallons.dart';
import 'package:fuel_smart/features/refueling/services/refueling_service.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminClientScreen extends StatefulWidget {
  final Clients clientSelected;

  const AdminClientScreen({super.key, required this.clientSelected});

  @override
  State<AdminClientScreen> createState() => _AdminClientScreenState();
}

class _AdminClientScreenState extends State<AdminClientScreen> {
  final RefuelingService refuelingService = RefuelingService();
  int currentMonth = DateTime.now().month;

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
        currentMonth, //mes actual
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
            "Administrar vehículos cliente ${widget.clientSelected.name}",
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
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
                            //ir a pantalla para administrar vehiculo
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AdminVehicleScreen(
                                  vehicleSelected: vehicle.idVehiculo,
                                ),
                              ),
                            );
                          },
                          child: const Text("ver"),
                        ),
                      );
                    },
                  ),
          ),
          DividerPersonalizated(thicknessSize: 1),
          // grafica consumo galones por placa
          SizedBox(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 300,

                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();

                          if (index >= 0 && index < vehicles.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                vehicles[index].placa,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ),

                  borderData: FlBorderData(show: false),

                  barGroups: List.generate(vehicles.length, (index) {
                    final vehicle = vehicles[index];

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: double.parse(vehicle.totalGalones),
                          width: 18,
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
