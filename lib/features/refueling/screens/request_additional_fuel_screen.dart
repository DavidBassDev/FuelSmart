import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/core/widgets/form_widget.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';
import 'package:fuel_smart/features/vehicles/services/vehicle_service.dart';
import 'package:fuel_smart/features/vehicles/widgets/card_status_widget.dart';
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

  bool isLoading = true;
  Vehicle? vehicle;
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
    String observation = "";
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
      body: isLoading
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
                Expanded(
                  child: FormWidget(
                    icon: Icons.edit_document,
                    obscureText: false,
                    controller: commentController,
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
    );
  }
}
