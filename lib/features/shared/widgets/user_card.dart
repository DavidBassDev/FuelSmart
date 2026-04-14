import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String plate;
  final String project;
  final bool isActive;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.plate,
    required this.project,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF8E3B57), // fondo rosado oscuro
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Avatar + estado
          Stack(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.black,
                child: Icon(Icons.person, color: Colors.white),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Placa: $plate',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
                Text(
                  'Proyecto: $project',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Botón
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A2C3E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onTap,
            child: const Text('Ver', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
