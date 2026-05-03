import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/features/refueling/data/datasources/refueling_service.dart';
import 'package:fuel_smart/features/refueling/presentation/widgets/fuel_request_card.dart';
import 'package:fuel_smart/features/vehicles/presentation/screens/admin_vehicle_screen.dart';
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
  String? token;

  @override
  void initState() {
    super.initState();
    loadRequests();
  }

  Future<void> loadRequests() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      token = auth.token;
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
    token = token;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vehículos con solicitud de cupo",
          style: TextStyle(fontSize: 18),
        ),
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
                final double consumidos =
                    double.tryParse(item['galones_consumidos'].toString()) ??
                    0.0;

                final double disponibles =
                    double.tryParse(item['cupo_combustible'].toString()) ?? 0.0;

                final double solicitados =
                    double.tryParse(item['galones_solicitados'].toString()) ??
                    0.0;

                return FuelRequestCard(
                  placa: item['placa'] ?? '',
                  consumidos: consumidos,
                  disponibles: disponibles,
                  cliente: item['cliente'] ?? '',
                  observacion: item['comentario'] ?? '',
                  solicitados: solicitados,
                  onPressed: () {
                    //IR A LA PANTALLA DE ADMINISTRAR VEHICULO
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdminVehicleScreen(
                          vehicleSelected: item['id_vehiculo'],
                        ),
                      ),
                    );
                  },
                  onApprove: () {
                    final auth = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );

                    showApproveDialog(
                      context: context,
                      onYes: () async {
                        try {
                          await service.updateFuelRequestStatus(
                            token!,
                            idSolicitud: item['id_solicitud'],
                            estado: 'aprobado',
                            respondidoPor: auth.user!.id,
                          );

                          await loadRequests();
                        } catch (e) {
                          debugPrint("ERROR aprobar: $e");
                        }
                      },
                      onNo: () async {
                        try {
                          await service.updateFuelRequestStatus(
                            token!,
                            idSolicitud: item['id_solicitud'],
                            estado: 'rechazado',
                            respondidoPor: auth.user!.id,
                          );

                          await loadRequests();
                        } catch (e) {
                          debugPrint("ERROR rechazar: $e");
                        }
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  void showApproveDialog({
    required BuildContext context,
    required VoidCallback onYes,
    required VoidCallback onNo,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // evita cerrar tocando afuera
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content: const Text("¿Desea aprobar la solicitud?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cerrar
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onNo(); // 👈 acción NO
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onYes(); // 👈 acción SI
              },
              child: const Text("Sí"),
            ),
          ],
        );
      },
    );
  }
}
