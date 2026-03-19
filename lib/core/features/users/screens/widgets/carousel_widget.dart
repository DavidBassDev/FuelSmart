import 'package:flutter/material.dart';
import 'package:fuel_smart/core/features/refueling/screens/refueling_screen.dart';
import 'package:fuel_smart/core/widgets/carousel_functions.dart';

class CarouselWidget extends StatelessWidget {
  final String token;

  const CarouselWidget({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CarouselFunctions(
          icon: Icons.person,
          text: 'Usuarios',
          onPressed: () {
            print("pressed");
          },
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.directions_car,
          text: "Admin.\nvehículos",
          onPressed: () {},
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.add_circle,
          text: "Crear\nvehículo",
          onPressed: () {},
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.local_gas_station,
          text: "Registrar\nrepostaje",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RefuelingScreen(token: token),
              ),
            );
          },
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.book,
          text: "Ver\nauditoria",
          onPressed: () {},
        ),
      ],
    );
  }
}
