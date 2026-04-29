import 'package:flutter/material.dart';
import 'package:fuel_smart/features/refueling/screens/refueling_screen.dart';
import 'package:fuel_smart/core/widgets/carousel_functions.dart';
import 'package:fuel_smart/features/shared/screens/users/admin_user_screen.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        CarouselFunctions(
          icon: Icons.person,
          text: 'Usuarios',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminUserScreen()),
            );
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RefuelingScreen()),
            );
          },
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.local_gas_station,
          text: "Registrar\nrepostaje",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RefuelingScreen()),
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
