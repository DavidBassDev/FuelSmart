import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/dashboard/data/models/low_fuel_model.dart';
import 'package:fuel_smart/features/dashboard/data/datasources/features_service.dart';
import 'package:fuel_smart/features/dashboard/presentation/widgets/low_fuel_item.dart';
import 'package:fuel_smart/features/vehicles/presentation/screens/admin_vehicle_screen.dart';
import 'package:provider/provider.dart';

class NoAvaliableFuelQuotaScreen extends StatefulWidget {
  const NoAvaliableFuelQuotaScreen({super.key});

  @override
  State<NoAvaliableFuelQuotaScreen> createState() =>
      _NoAvaliableFuelQuotaScreen();
}

class _NoAvaliableFuelQuotaScreen extends State<NoAvaliableFuelQuotaScreen> {
  final FeaturesService featuresService = FeaturesService();
  bool isLoading = true;

  List<LowFuelVehicle> lowFuelList = [];

  @override
  void initState() {
    super.initState();
    loadNoAvaliableFuelQuota();
  }

  Future<void> loadNoAvaliableFuelQuota() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      String token = auth.token!;
      final response = await featuresService.noAvaliableFuelQuota(token);

      final List data = response['data'];

      setState(() {
        lowFuelList = data
            .map((item) => LowFuelVehicle.fromJson(item))
            .toList();

        isLoading = false;
      });
    } catch (e) {
      print("Error cargando lista de vehículos sin combustible $e");

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
            "Vehículos con cupo agotado",
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
          SizedBox(height: 20),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : lowFuelList.isEmpty
                ? const Center(
                    child: Text("No hay vehículos con cupo bajo en el momento"),
                  )
                : ListView.builder(
                    itemCount: lowFuelList.length,
                    itemBuilder: (context, index) {
                      final item = lowFuelList[index];
                      var clienteName = item.clienteNombre;
                      clienteName ??= 'Sede principal';

                      return LowFuelItem(
                        placa: item.placa,
                        galonesConsumidos: item.totalGalones.toInt(),
                        galonesDisponibles:
                            (item.cupoCombustible - item.totalGalones).toInt(),
                        cliente: clienteName,
                        onTap: () {
                          //ir a pantalla para administrar vehiculo
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AdminVehicleScreen(
                                vehicleSelected: item.idVehiculo,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          DividerPersonalizated(thicknessSize: 1),
        ],
      ),
    );
  }
}
