import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/pending_carousel_functions.dart';
import 'package:fuel_smart/features/refueling/screens/refueling_screen.dart';
import 'package:fuel_smart/features/refueling/screens/request_additional_fuel_screen.dart';

class CarouselWidgetDriver extends StatelessWidget {
  final String token;

  const CarouselWidgetDriver({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(width: 15),
      itemBuilder: (context, index) {
        if (index == 0) {
          return PendingCarouselFunctions(
            icon: Icons.car_repair,
            text: 'Registrar repostaje',
            subtitle:
                'Utiliza este módulo solo\nSi vas a repostar bajo caja menor.',
            onPressed: () {
              RefuelingScreen();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RefuelingScreen()),
              );
            },
          );
        } else {
          return PendingCarouselFunctions(
            icon: Icons.local_gas_station_outlined,
            text: "Solicitar ampliación de cupo",
            subtitle:
                'Solicita ampliar el cupo de \ntu vehículo para continuar tu operación',
            onPressed: () {
              RefuelingScreen();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestAdditionalFuelScreen(),
                ),
              );
            },
          );
        }
      },
    );
  }
}
