import 'package:flutter/material.dart';

class TelemetryVehicleWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const TelemetryVehicleWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final fecha = DateTime.parse(item['fecha']);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF7A2F45), // color vinotinto
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // ICONO
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.description, color: Colors.black),
          ),

          const SizedBox(width: 16),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fecha : ${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}",
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 6),

                Text(
                  "Distancia Recorrida: ${item['distancia_km']}",
                  style: const TextStyle(color: Colors.white),
                ),

                Text(
                  "Porcentaje ralentí: ${item['tiempo_ralenti_seg'] ?? 0}%",
                  style: const TextStyle(color: Colors.white),
                ),

                Text(
                  "Odómetro Final: ${item['odometro'] ?? 0}",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
