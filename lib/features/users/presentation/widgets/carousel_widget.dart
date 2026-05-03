import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/nav_provider.dart';
import 'package:fuel_smart/features/users/presentation/widgets/carousel_functions.dart';
import 'package:fuel_smart/features/users/presentation/screens/admin_user_screen.dart';
import 'package:fuel_smart/features/vehicles/presentation/screens/create_vehicle_screen.dart';
import 'package:fuel_smart/features/vehicles/presentation/screens/admin_vehicles_operation_screen.dart';
import 'package:provider/provider.dart';

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AdminVehiclesOperationScreen()),
            );
          },
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.add_circle,
          text: "Crear\nvehículo",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreateVehicleScreen()),
            );
          },
        ),
        SizedBox(width: 20),
        CarouselFunctions(
          icon: Icons.local_gas_station,
          text: "Registrar\nrepostaje",
          onPressed: () {
            Provider.of<NavProvider>(context, listen: false).changeIndex(1);
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
