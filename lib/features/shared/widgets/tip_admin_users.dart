import 'package:flutter/material.dart';

class TipAdminUsers extends StatefulWidget {
  const TipAdminUsers({super.key});

  @override
  State<TipAdminUsers> createState() => _TipAdminUsersState();
}

class _TipAdminUsersState extends State<TipAdminUsers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 128, 44, 65),
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
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Descripción
          Text(
            'Gestiona correctamente los permisos de cada usuario para mantener la seguridad y el buen funcionamiento del sistema.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 12),

          // Tips
          _item('Asigna roles según la responsabilidad'),
          _item('Revisa periódicamente los accesos'),
          _item('Mantén la información actualizada'),

          const SizedBox(height: 12),

          Text(
            'Una buena gestión mejora el trabajo en equipo 🔒',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
