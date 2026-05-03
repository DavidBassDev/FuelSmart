import 'package:flutter/material.dart';

class CardAdminUser extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String descripcion;
  final VoidCallback onPressed;
  final String nameButtom;

  const CardAdminUser({
    super.key,
    required this.icon,
    required this.titulo,
    required this.descripcion,
    required this.onPressed,
    required this.nameButtom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // ICONO
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 35, 35, 35),
              size: 60,
            ),
          ),

          const SizedBox(width: 16),

          // TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  textAlign: TextAlign.left,
                  descripcion,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.8),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // BOTÓN
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              nameButtom,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
