import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/nav_provider.dart';
import 'package:fuel_smart/core/widgets/pending_carousel_functions.dart';
import 'package:provider/provider.dart';

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
            print("pressed");
          },
        ),
        SizedBox(width: 20),
        PendingCarouselFunctions(
          icon: Icons.local_gas_station_outlined,
          text: "Vehículos con\npoco cupo disponible",
          onPressed: () {},
        ),
        SizedBox(width: 20),
        PendingCarouselFunctions(
          icon: Icons.car_crash,
          text: "Vehiculos sin\ncupo disponible",
          onPressed: () {
            Provider.of<NavProvider>(context, listen: false).changeIndex(1);
          },
        ),
      ],
    );
  }
}
