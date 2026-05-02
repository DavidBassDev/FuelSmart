import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/pending_carousel_functions.dart';
import 'package:fuel_smart/features/dashboard/screens/low_fuel_screen.dart';

class CarouselWidgetDriver extends StatelessWidget {
  final String token;

  const CarouselWidgetDriver({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        PendingCarouselFunctions(
          icon: Icons.car_repair,
          text: 'Registrar repostaje',
          onPressed: () {
            print("pressed");
          },
        ),
        SizedBox(width: 20),
        PendingCarouselFunctions(
          icon: Icons.local_gas_station_outlined,
          text: "Vehículos ampliacion\nde cupo",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LowFuelScreen()),
            );
          },
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
