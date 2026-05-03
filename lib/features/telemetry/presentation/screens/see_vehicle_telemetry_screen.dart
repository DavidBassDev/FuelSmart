import 'package:flutter/material.dart';
import 'package:fuel_smart/features/telemetry/data/telemetry_service.dart';
import 'package:fuel_smart/features/telemetry/presentation/widgets/telemetry_vehicle_widget.dart';

class SeeVehicleTelemetryScreen extends StatefulWidget {
  final String plate;

  const SeeVehicleTelemetryScreen({super.key, required this.plate});

  @override
  State<SeeVehicleTelemetryScreen> createState() =>
      _SeeVehicleTelemetryScreen();
}

class _SeeVehicleTelemetryScreen extends State<SeeVehicleTelemetryScreen> {
  final TelemetryService _service = TelemetryService();

  List<Map<String, dynamic>> telemetryMovements = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTelemetryVehicle();
  }

  Future<void> _loadTelemetryVehicle() async {
    try {
      final data = await _service.getTelemetryPlateList(widget.plate);

      setState(() {
        telemetryMovements = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error cargando movimientos GPS: $e");
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
            "Registros telemetria GPS ${widget.plate}",
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : telemetryMovements.isEmpty
          ? const Center(child: Text("No hay registros GPS"))
          : RefreshIndicator(
              onRefresh: _loadTelemetryVehicle,
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: telemetryMovements.length,
                itemBuilder: (_, i) {
                  final item = telemetryMovements[i];

                  return TelemetryVehicleWidget(item: item);
                },
              ),
            ),
    );
  }
}
