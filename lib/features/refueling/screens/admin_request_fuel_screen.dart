import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/features/refueling/services/refueling_service.dart';
import 'package:fuel_smart/features/refueling/widgets/fuel_request_card.dart';
import 'package:provider/provider.dart';

class FuelRequestListScreen extends StatefulWidget {
  const FuelRequestListScreen({super.key});

  @override
  State<FuelRequestListScreen> createState() => _FuelRequestListScreenState();
}

class _FuelRequestListScreenState extends State<FuelRequestListScreen> {
  final RefuelingService service = RefuelingService();

  List<dynamic> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRequests();
  }

  Future<void> loadRequests() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      final data = await service.getPendingFuelRequests(auth.token!);

      setState(() {
        requests = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("ERROR: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehículos con solicitud de cupo"),
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : requests.isEmpty
          ? const Center(child: Text("No hay solicitudes pendientes"))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = requests[index];

                // 🔥 parsing seguro
                final int consumidos =
                    int.tryParse(item['galones_consumidos'].toString()) ?? 0;

                final int disponibles =
                    int.tryParse(item['cupo_combustible'].toString()) ?? 0;

                return FuelRequestCard(
                  placa: item['placa'] ?? '',
                  consumidos: consumidos,
                  disponibles: disponibles,
                  cliente: item['cliente'] ?? '',
                  observacion: item['comentario'] ?? '',
                  onPressed: () {
                    print("Ver solicitud ${item['id_solicitud']}");

                    // 👉 luego puedes navegar a detalle
                    // Navigator.push(...)
                  },
                );
              },
            ),
    );
  }
}
