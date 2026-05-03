import 'package:flutter/material.dart';

class FuelRequestCard extends StatelessWidget {
  final String placa;
  final double consumidos;
  final double disponibles;
  final double solicitados;
  final String cliente;
  final String observacion;
  final VoidCallback onPressed;
  final VoidCallback onApprove; // 👈 nuevo callback

  const FuelRequestCard({
    super.key,
    required this.placa,
    required this.consumidos,
    required this.disponibles,
    required this.cliente,
    required this.observacion,
    required this.onPressed,
    required this.solicitados,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🔹 Icono
        const Icon(Icons.person, size: 40, color: Colors.black),

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

        // 🔹 Botones
        Column(
          children: [
            ElevatedButton(
              onPressed: onApprove,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2D3E2D),
              ),
              child: const Text(
                "Aprobar",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2D3E2D),
              ),
              child: const Text("Ver", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
