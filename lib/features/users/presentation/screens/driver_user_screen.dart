import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/data/datasources/refueling_service.dart';
import 'package:fuel_smart/features/refueling/presentation/widgets/status_request_fuel_widget.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/features/users/presentation/widgets/carousel_widget_driver.dart';
import 'package:fuel_smart/features/users/presentation/widgets/tip_driver_users.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/card_admin_vehicle_driver.dart';
import 'package:provider/provider.dart';

class DriverUserScreen extends StatefulWidget {
  const DriverUserScreen({super.key});

  @override
  State<DriverUserScreen> createState() => _DriverUserScreenState();
}

class _DriverUserScreenState extends State<DriverUserScreen> {
  final RefuelingService service = RefuelingService();

  List<dynamic> requests = [];
  bool isLoading = true;
  String? statusRequest;

  @override
  void initState() {
    super.initState();
    loadMyRequest();
  }

  Future<void> loadMyRequest() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      final data = await service.getMyFuelRequest(auth.token!);

      // ✅ obtener estado correctamente
      if (data.isNotEmpty) {
        statusRequest = data[0]['estado'];
      } else {
        statusRequest = null;
      }

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
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLogged || auth.user == null || auth.token == null) {
      return const Scaffold(body: Center(child: Text("Token inválido")));
    }

    final User user = auth.user!;
    final token = auth.token!;

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 HEADER
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Bienvenido ${user.nombre}',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            user.rol ?? '',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      const DividerPersonalizated(thicknessSize: 1),

                      // 🔹 CARD VEHICULO
                      const CardAdminVehicleDriver(),

                      const SizedBox(height: 20),

                      // 🔹 ACCIONES
                      Row(
                        children: [
                          Text(
                            'Acciones',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_right,
                                color: Theme.of(context).colorScheme.primary,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 210,
                        child: CarouselWidgetDriver(token: token),
                      ),

                      const SizedBox(height: 20),
                      const DividerPersonalizated(thicknessSize: 1),

                      const SizedBox(height: 10),

                      // 🔹 ESTADO SOLICITUD
                      if (statusRequest != null)
                        Row(
                          children: [
                            StatusRequestFuelWidget(estado: statusRequest!),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                'La solicitud de aumento al vehículo ha sido $statusRequest',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        )
                      else
                        const Text("No hay solicitudes registradas"),

                      const SizedBox(height: 15),

                      // 🔹 TIP
                      const TipDriverUsers(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
