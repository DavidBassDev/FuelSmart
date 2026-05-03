import 'package:flutter/material.dart';
import 'package:fuel_smart/features/users/presentation/screens/see_user_screen.dart';
import 'package:fuel_smart/features/users/models/user.dart';

class BuildUserItemWidget extends StatelessWidget {
  final User user;
  final VoidCallback? onPressed;

  const BuildUserItemWidget({super.key, required this.user, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            size: 40,
            color: Theme.of(context).colorScheme.error,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Placa: ${user.placa ?? 'sin dato'}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Text(
                  "Cliente: ${user.nombreProyecto ?? 'Sede Principal'}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed:
                onPressed ??
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SeeUserScreen(userSelected: user),
                    ),
                  );
                },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text("Ver", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
