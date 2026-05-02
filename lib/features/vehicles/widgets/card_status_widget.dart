import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/services/telemetry/telemetry_service.dart';
import 'package:fuel_smart/features/refueling/models/fuel_assignment.dart';
import 'package:fuel_smart/features/refueling/services/refueling_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:provider/provider.dart';

class CardStatusWidget extends StatefulWidget {
  final Vehicle vehicle;
  final intVehicle;
  const CardStatusWidget({super.key, required this.vehicle, this.intVehicle});

  @override
  State<CardStatusWidget> createState() => _CardStatusWidgetState();
}

class _CardStatusWidgetState extends State<CardStatusWidget> {
  final TelemetryService telemetryService = TelemetryService();
  final RefuelingService refuelingService = RefuelingService();
  FuelAssignment? fuelAssignment;
  bool isLoading = true;
  double totalGallons = 0.0;

  @override
  void initState() {
    super.initState();
    getGallonsConsumed();
  }

  // Cargar consumos del vehículo
  Future<void> getGallonsConsumed() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final token = authProvider.token;

      if (token == null) return;

      final currentMonth = DateTime.now().month;

      final response = await refuelingService.getGallonsConsumed(
        token,
        widget.intVehicle,
        currentMonth,
      );

      setState(() {
        final data = response['data'];

        totalGallons = data != null
            ? double.tryParse(data['total_galones']?.toString() ?? '0') ?? 0.0
            : 0.0;

        isLoading = false;
      });

      print("TOTAL GALONES: $totalGallons");
    } catch (e) {
      print("Error cargando consumos del vehículo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double performance = totalGallons / 100;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary,
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
                      "Rendimiento teorico: ${widget.vehicle.teoricPerformance}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rendimiento: $performance%",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
