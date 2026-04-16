import 'package:flutter/material.dart';

class TipAdminUsers extends StatelessWidget {
  const TipAdminUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Consejos rápidos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Descripción
          const Text(
            'Gestiona correctamente los permisos de cada usuario para mantener la seguridad y el buen funcionamiento del sistema.',
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 12),

          // Tips
          _item('Asigna roles según la responsabilidad'),
          _item('Revisa periódicamente los accesos'),
          _item('Mantén la información actualizada'),

          const SizedBox(height: 12),

          const Text(
            'Una buena gestión mejora el trabajo en equipo ❤️',
            style: TextStyle(color: Colors.white54),
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
            child: Text(text, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
