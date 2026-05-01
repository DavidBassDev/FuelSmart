import 'package:flutter/material.dart';

class LowFuelItem extends StatelessWidget {
  final String placa;
  final int galonesConsumidos;
  final int galonesDisponibles;
  final String cliente;
  final String observacion;
  final VoidCallback onTap;

  const LowFuelItem({
    super.key,
    required this.placa,
    required this.galonesConsumidos,
    required this.galonesDisponibles,
    required this.cliente,
    required this.observacion,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF8E3B52), // adaptar al tema
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICONO
          const Icon(
            Icons.person,
            size: 40,
            color: Colors.black,
          ), //adaptar al tema

          const SizedBox(width: 10),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placa,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  "Galones Consumidos: $galonesConsumidos",
                  style: const TextStyle(
                    color: Colors.white70,
                  ), //adaptar al tema
                ),

                Text(
                  "Galones Disponibles: $galonesDisponibles",
                  style: const TextStyle(
                    color: Colors.white, //adaptar al tema
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Cliente $cliente",
                  style: const TextStyle(
                    color: Colors.white70,
                  ), //adaptar al tema
                ),

                Text(
                  "Observación: $observacion",
                  style: const TextStyle(
                    color: Colors.white54,
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
