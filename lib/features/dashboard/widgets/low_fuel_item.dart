import 'package:flutter/material.dart';

class LowFuelItem extends StatelessWidget {
  final String placa;
  final int galonesConsumidos;
  final int galonesDisponibles;
  final String cliente;

  final VoidCallback onTap;

  const LowFuelItem({
    super.key,
    required this.placa,
    required this.galonesConsumidos,
    required this.galonesDisponibles,
    required this.cliente,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICONO
          Icon(
            Icons.person,
            size: 40,
            color: Theme.of(context).colorScheme.onError,
          ),

          const SizedBox(width: 10),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placa,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  "Galones Consumidos: $galonesConsumidos",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                  ), //adaptar al tema
                ),

                Text(
                  "Galones Disponibles: $galonesDisponibles",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onError,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Cliente $cliente",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ), //adaptar al tema
                ),
              ],
            ),
          ),

          // BOTÓN
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5E2330), //adaptar al tema
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Ver"),
          ),
        ],
      ),
    );
  }
}
