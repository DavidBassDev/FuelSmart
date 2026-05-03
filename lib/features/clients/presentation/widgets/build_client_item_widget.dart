import 'package:flutter/material.dart';
import 'package:fuel_smart/features/clients/data/models/client_model.dart';

class BuildClientItemWidget extends StatelessWidget {
  final Clients client;
  final VoidCallback? onPressed;

  const BuildClientItemWidget({
    super.key,
    required this.client,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.business,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Cantidad de placas: ${client.cantidadPlacas ?? 0}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: onPressed,
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
