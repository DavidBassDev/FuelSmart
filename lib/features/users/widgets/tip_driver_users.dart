import 'package:flutter/material.dart';

class TipDriverUsers extends StatefulWidget {
  const TipDriverUsers({super.key});

  @override
  State<TipDriverUsers> createState() => _TipDriverUsers();
}

class _TipDriverUsers extends State<TipDriverUsers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Consejos rápido',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Descripción
          Text(
            'Consulta el estado de tus vehículos y gestiona tu consumo de combustible de forma eficiente.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),

          const SizedBox(height: 12),

          // Tips
          _item(
            'Revisa el panel "Administrar mis vehículos" para conocer el consumo y rendimiento actual',
          ),
          _item(
            'Solicita la ampliación de cupo con anticipación para evitar bloqueos en el suministro',
          ),
          _item(
            'Haz seguimiento constante a tus consumos para mantener el control operativo',
          ),

          const SizedBox(height: 12),

          Text(
            'Una buena gestión del combustible mejora la eficiencia y reduce costos ⛽',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
