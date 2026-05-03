import 'package:flutter/material.dart';

class FuelRequestCard extends StatelessWidget {
  final String placa;
  final double consumidos;
  final double disponibles;
  final double solicitados;
  final String cliente;
  final String observacion;
  final VoidCallback onPressed;

  const FuelRequestCard({
    super.key,
    required this.placa,
    required this.consumidos,
    required this.disponibles,
    required this.cliente,
    required this.observacion,
    required this.onPressed,
    required this.solicitados,
  });
  //ACOMODAR TODOS LOS COLORES AL THEME
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🔹 Icono
        const Icon(Icons.person, size: 40),

        const SizedBox(width: 12),

        // 🔹 Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                placa,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text("Galones Consumidos: ${consumidos.toStringAsFixed(2)}"),
              Text("Galones Disponibles: ${disponibles.toStringAsFixed(2)}"),
              Text("Galones Solicitados: ${solicitados.toStringAsFixed(2)}"),
              Text(cliente),
              Text(
                "Observación: $observacion",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),

        // 🔹 Botón
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black26),
          child: const Text("Ver"),
        ),
      ],
    );
  }
}
