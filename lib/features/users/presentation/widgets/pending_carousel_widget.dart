import 'package:flutter/material.dart';
import 'package:fuel_smart/features/users/presentation/widgets/pending_carousel_functions.dart';
import 'package:fuel_smart/features/dashboard/presentation/screens/low_fuel_screen.dart';
import 'package:fuel_smart/features/dashboard/presentation/screens/no_avaliable_fuel_quota_screen.dart';
import 'package:fuel_smart/features/refueling/presentation/screens/admin_request_fuel_screen.dart';

class PendingCarouselWidget extends StatelessWidget {
  final String token;

  const PendingCarouselWidget({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        PendingCarouselFunctions(
          icon: Icons.car_repair,
          text: 'Vehículos con \nsolicitud de cupo',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FuelRequestListScreen()),
            );
          },
        ),
        SizedBox(width: 20),
        PendingCarouselFunctions(
          icon: Icons.local_gas_station_outlined,
          text: "Vehículos con\npoco cupo disponible",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LowFuelScreen()),
            );
          },
        ),
        SizedBox(width: 20),
        PendingCarouselFunctions(
          icon: Icons.car_crash,
          text: "Vehiculos sin\ncupo disponible",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NoAvaliableFuelQuotaScreen()),
            );
          },
        ),
      ],
    );
  }
}
