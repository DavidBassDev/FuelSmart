import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/providers/themee_provider.dart';
import 'package:fuel_smart/features/refueling/presentation/screens/see_refuelings_vehicle_screen.dart';
import 'package:fuel_smart/features/refueling/data/datasources/refueling_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/data/datasources/vehicle_service.dart';
import 'package:provider/provider.dart';

class CardAdminVehicleDriver extends StatefulWidget {
  const CardAdminVehicleDriver({super.key});

  @override
  State<CardAdminVehicleDriver> createState() => _CardAdminVehicleDriverState();
}

class _CardAdminVehicleDriverState extends State<CardAdminVehicleDriver> {
  final RefuelingService refuelingService = RefuelingService();
  final VehicleService vehicleService = VehicleService();
  bool isLoading = true;
  double totalGallons = 0.0;
  int vehicleId = 0;
  Vehicle? vehicle;
  double actualPerformance = 0.0;
  double effiency = 0.0;
  double avaliableFuel = 0.0;

  @override
  void initState() {
    super.initState();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final id = int.tryParse(authProvider.user!.idVehicle ?? '') ?? 0;

    vehicleId = id;

    loadVehicle(vehicleId);
  }

  // Cargar consumos del vehículo
  Future<void> getGallonsConsumed() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      final token = authProvider.token;

      if (token == null) return;

      vehicleId = int.tryParse(authProvider.user!.idVehicle ?? '') ?? 0;

      final currentMonth = DateTime.now().month;

      final response = await refuelingService.getGallonsConsumed(
        token,
        vehicleId,
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

  //TRAER VEHICULO
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    var asset = "assets/images/car_check.png";
    if (themeProvider.type == AppThemeType.beige) {
      asset = "assets/images/car_check_white.png";
    }

    // 🔹 evitar crash si vehicle aún no carga
    final double totalDisponible = vehicle?.avaliableFuel ?? 0.0;
    final double disponible = (totalDisponible - totalGallons).clamp(
      0,
      totalDisponible,
    );

    // 🔹 porcentaje (0 a 1)
    final double porcentaje = totalDisponible > 0
        ? (disponible / totalDisponible)
        : 0.0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface,
          width: 3,
        ),
      ),
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        onTap: () {
          if (vehicle == null) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SeeRefuelingsVehicleScreen(
                totalGallons: totalGallons,
                vehicle: vehicle!,
                vehicleId: vehicleId,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // 🔹 INFO IZQUIERDA
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Administrar mi vehículo",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Cupo disponible: ${disponible.toStringAsFixed(1)} gal",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 🔹 CIRCULO DE PORCENTAJE
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(
                            value: porcentaje,
                            strokeWidth: 6,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              porcentaje > 0.5
                                  ? Colors.green
                                  : porcentaje > 0.2
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                          ),
                        ),
                        Text(
                          "${(porcentaje * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // 🔹 IMAGEN
              Image.asset(asset, width: 100, fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}
