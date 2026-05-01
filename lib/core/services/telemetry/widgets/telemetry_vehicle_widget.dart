import 'package:flutter/material.dart';

class TelemetryVehicleWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const TelemetryVehicleWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final fecha = DateTime.parse(item['fecha']);

    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 16, // puedes ajustar
      color: Theme.of(context).colorScheme.onSurface,
    );

    //otro textStyle para que no se vea tan pesado visualmente
    final textStyle2 = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: 16, // puedes ajustar
      color: Theme.of(context).colorScheme.onSurface,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
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
            child: Icon(
              Icons.description,
              color: Theme.of(context).colorScheme.error,
            ),
          ),

          const SizedBox(width: 16),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fecha : ${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}",
                  style: textStyle2,
                ),

                const SizedBox(height: 6),

                Text(
                  "Distancia Recorrida: ${item['distancia_km']}",
                  style: textStyle,
                ),

                Text(
                  "Porcentaje ralentí: ${item['tiempo_ralenti_seg'] ?? 0}%",
                  style: textStyle2,
                ),

                Text(
                  "Odómetro Final: ${item['odometro_km'] ?? 0}",
                  style: textStyle2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
