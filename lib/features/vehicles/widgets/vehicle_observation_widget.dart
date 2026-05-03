import 'package:flutter/material.dart';

class VehicleObservationWidget extends StatelessWidget {
  final String observation;

  const VehicleObservationWidget({super.key, required this.observation});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade900, //acomodar al theme
            Colors.green.shade700, //acomodar al theme
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.directions_car_filled,
            color: Colors.white, //acomodar al theme
            size: 28,
          ),
          const SizedBox(width: 12),

          /// TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Comportamiento de tu vehículo",
                  style: TextStyle(
                    color: Colors.white, //acomodar al theme
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  observation.isNotEmpty
                      ? observation
                      : "Aun no has presentado consumos y movimientos",
                  style: const TextStyle(
                    color: Colors.white70, //acomodar al theme
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
