import 'package:flutter/material.dart';

class StatusRequestFuelWidget extends StatelessWidget {
  final String estado;

  const StatusRequestFuelWidget({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (estado.toLowerCase()) {
      case 'aprobado':
        icon = Icons.sentiment_satisfied_alt;
        color = Colors.green;
        break;
      case 'pendiente':
        icon = Icons.sentiment_neutral;
        color = Colors.orange;
        break;
      case 'rechazado':
        icon = Icons.sentiment_dissatisfied;
        color = Colors.red;
        break;
      default:
        icon = Icons.help;
        color = Colors.grey;
    }

    return Icon(icon, color: color, size: 32);
  }
}
