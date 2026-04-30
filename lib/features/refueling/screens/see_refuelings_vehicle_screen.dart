import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/widgets/card_fuel_performance.dart';
import 'package:fuel_smart/features/refueling/widgets/refueling_item_widget.dart';
import 'package:fuel_smart/features/refueling/models/refueling_list_item.dart';
import 'package:fuel_smart/features/refueling/services/refueling_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:provider/provider.dart';

class SeeRefuelingsVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;
  final double totalGallons;

  const SeeRefuelingsVehicleScreen({
    super.key,
    required this.vehicle,
    required this.totalGallons,
  });

  @override
  State<SeeRefuelingsVehicleScreen> createState() =>
      _SeeRefuelingsVehicleScreenState();
}

class _SeeRefuelingsVehicleScreenState
    extends State<SeeRefuelingsVehicleScreen> {
  final RefuelingService _service = RefuelingService();

  List<RefuelingListItem> refuelings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRefuelings();
  }

  Future<void> _loadRefuelings() async {
    try {
      final token = context.read<AuthProvider>().token;

      final data = await _service.getVehiclesWithGallonsList(
        token!,
        widget.vehicle.vehicleId,
      );

      setState(() {
        refuelings = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error cargando consumos: $e");
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
            "Ver rendimiento y consumos",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CardFuelPerformance(
            vehicle: widget.vehicle,
            totalGallons: widget.totalGallons,
          ),

          const SizedBox(height: 20),
          DividerPersonalizated(thicknessSize: 1),
          const SizedBox(height: 10),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : refuelings.isEmpty
                ? const Center(child: Text("No hay consumos"))
                : RefreshIndicator(
                    onRefresh: _loadRefuelings,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: refuelings.length,
                      itemBuilder: (_, i) {
                        final item = refuelings[i];

                        return RefuelingItemWidget(
                          item: item,

                          // solo si es por  Caja Menor
                          onTap: item.tipo.toLowerCase() == "caja menor"
                              ? () {
                                  debugPrint("Ver detalle ${item.id}");
                                }
                              : null,
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
