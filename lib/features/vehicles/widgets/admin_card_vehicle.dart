import 'package:flutter/material.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';

class AdminCardVehicle extends StatelessWidget {
  final Vehicle vehicle;
  const AdminCardVehicle({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 8,
        ),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      vehicle.plate,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.black),

                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      vehicle.typeOfVehicle.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rendimiento teorico: ${vehicle.teoricPerformance}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black),

                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Conductor: ${vehicle.userName}",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Image.asset(
                "assets/images/logoPluxee.png",
                width: 120,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
