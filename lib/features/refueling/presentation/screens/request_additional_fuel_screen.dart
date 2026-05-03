import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/button_action.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/core/widgets/show_dialog.dart';
import 'package:fuel_smart/features/refueling/data/datasources/refueling_service.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/data/datasources/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/card_status_widget.dart';
import 'package:fuel_smart/features/vehicles/presentation/widgets/vehicle_observation_widget.dart';
import 'package:provider/provider.dart';

class RequestAdditionalFuelScreen extends StatefulWidget {
  const RequestAdditionalFuelScreen({super.key});

  @override
  State<RequestAdditionalFuelScreen> createState() =>
      _RequestAdditionalFuelScreenState();
}

class _RequestAdditionalFuelScreenState
    extends State<RequestAdditionalFuelScreen> {
  final VehicleService vehicleService = VehicleService();
  String observation = "";
  bool isLoading = true;
  Vehicle? vehicle;
  int? requestBy;
  final gallonsController = TextEditingController();
  final commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadVehicle();
  }

  //TRAER VEHÍCULO
  Future<void> loadVehicle() async {
    try {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      final User? user = auth.user;
      print('llega el usuario ${user?.nombre}');
      print('con token ${auth.token}');
      print('con idvehicle ${user?.idVehicle}');

      final int? intVehicle = int.tryParse(user?.idVehicle ?? '');

      if (intVehicle == null) {
        throw Exception("ID de vehículo inválido");
      }

      final response = await vehicleService.getVehicle(intVehicle);

      final Vehicle data = response;

      setState(() {
        requestBy = user!.id;
        vehicle = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error cargando vehículo: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ampliación de cupo",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 20),
                  DividerPersonalizated(thicknessSize: 1),
                  const SizedBox(height: 20),
                  CardStatusWidget(
                    vehicle: vehicle!,
                    intVehicle: vehicle!.vehicleId,
                    onObservationChanged: (value) {
                      setState(() {
                        observation = value;
                        print("comentario que llega $observation");
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DividerPersonalizated(thicknessSize: 1),
                  //Formulario Solicitud
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Galones solicitados",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormWidget(
                          icon: Icons.local_gas_station_outlined,
                          obscureText: false,
                          controller: gallonsController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Observación solicitud",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FormWidget(
                      icon: Icons.edit_document,
                      obscureText: false,
                      controller: commentController,
                    ),
                  ),
                  SizedBox(height: 25),
                  DividerPersonalizated(thicknessSize: 1),
                  VehicleObservationWidget(observation: observation),
                  SizedBox(height: 30),
                  ButtonAction(
                    text: 'Solicitar aumento',
                    onPressed: () async {
                      try {
                        final auth = Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        );

                        final galones = double.tryParse(gallonsController.text);

                        if (galones == null || galones <= 0) {
                          throw Exception(
                            "Ingrese una cantidad válida de galones",
                          );
                        }

                        if (vehicle == null || requestBy == null) {
                          throw Exception("Datos del vehículo no disponibles");
                        }
                        final idFuelSupplier = vehicle?.fuelSupplierId ?? 3;

                        final response = await RefuelingService()
                            .createFuelRequest(
                              auth.token!,
                              idVehiculo: vehicle!.vehicleId,
                              galones: galones,
                              comentario: commentController.text,
                              solicitadoPor: requestBy!,
                              idProveedor: idFuelSupplier,
                            );

                        print("RESPONSE: $response");

                        await showDialog(
                          context: context,
                          builder: (context) => const ShowDialogPersonalizated(
                            text: 'Solicitud registrada correctamente!',
                          ),
                        );
                      } catch (e) {
                        print("ERROR: $e");

                        await showDialog(
                          context: context,
                          builder: (context) =>
                              ShowDialogPersonalizated(text: e.toString()),
                        );
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
