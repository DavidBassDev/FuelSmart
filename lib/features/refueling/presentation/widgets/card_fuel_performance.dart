import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/features/telemetry/presentation/screens/see_vehicle_telemetry_screen.dart';
import 'package:fuel_smart/features/telemetry/data/telemetry_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:provider/provider.dart';

class CardFuelPerformance extends StatefulWidget {
  final Vehicle vehicle;
  final double totalGallons;
  const CardFuelPerformance({
    super.key,
    required this.vehicle,
    required this.totalGallons,
  });

  @override
  State<CardFuelPerformance> createState() => _CardFuelPerformanceState();
}

class _CardFuelPerformanceState extends State<CardFuelPerformance> {
  final TelemetryService telemetryService = TelemetryService();
  double totalDistance = 0.0;
  double actualPerformance = 0.0;

  @override
  void initState() {
    super.initState();
    loadTelemetry();
  }

  // Cargar recorridos del vehículo
  Future<void> loadTelemetry() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;

      if (token == null) return;

      final int currentMonth = DateTime.now().month;
      final int currentYear = DateTime.now().year;

      final response = await telemetryService.getTelemetry(
        widget.vehicle.plate,
        currentMonth.toString(),
        currentYear.toString(),
      );

      //validar que sea JSON valido
      if (response == null || response is! Map<String, dynamic>) {
        return;
      }

      //anejo seguro de tipo
      final distancia = response['total_distancia_km'];

      final parsedDistance = distancia is num
          ? distancia.toDouble()
          : double.tryParse(distancia.toString()) ?? 0.0;

      setState(() {
        totalDistance = parsedDistance;
        actualPerformance = calculatePerformance(
          parsedDistance,
          widget.totalGallons,
        );
      });
    } catch (e) {}
  }

  double calculatePerformance(double distance, double gallons) {
    if (gallons <= 0) return 0.0;

    double result = distance / gallons;

    return double.parse(result.toStringAsFixed(2));
  }

  double calculateEfficiency(
    double actualPerformance,
    double teoricPerformance,
  ) {
    if (teoricPerformance <= 0) return 0.0;

    double result = (actualPerformance / teoricPerformance) * 100;

    return double.parse(result.toStringAsFixed(2));
  }

  Widget build(BuildContext context) {
    final eficiencia = calculateEfficiency(
      actualPerformance,
      widget.vehicle.teoricPerformance,
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 8,
        ),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.vehicle.plate,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.black),

                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.vehicle.typeOfVehicle.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rendimiento teorico : ${widget.vehicle.teoricPerformance}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black),

                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rendimiento actual :$actualPerformance",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Eficiencia: ${eficiencia.toStringAsFixed(2)}%",
                      style: TextStyle(
                        color: eficiencia >= 90
                            ? Colors.green
                            : (eficiencia >= 70 ? Colors.orange : Colors.red),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeVehicleTelemetryScreen(
                              plate: widget.vehicle.plate,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Distancia recorrida $totalDistance",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 2, 2),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Image.asset(
                "assets/images/logoPluxee.png",
                width: 120,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
