import 'package:flutter/material.dart';
import 'package:fuel_smart/features/refueling/models/refueling_list_item.dart';
import 'package:intl/intl.dart';

class RefuelingItemWidget extends StatelessWidget {
  final RefuelingListItem item;
  final VoidCallback? onTap;

  const RefuelingItemWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat("#,##0", "es_CO");
    final dateFormat = DateFormat("dd/MM/yyyy");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICONO
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.error),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.receipt_long, size: 30),
          ),

          const SizedBox(width: 12),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(
                  context,
                  "Cantidad galones: ${item.galones.toStringAsFixed(2)}",
                ),
                _text(
                  context,
                  "Odómetro: ${currencyFormat.format(item.odometro)}",
                ),
                _text(context, "Valor: \$${currencyFormat.format(item.valor)}"),
                _text(context, "Proveedor: ${item.tipo}"),
                _text(context, "Fecha: ${dateFormat.format(item.fecha)}"),
              ],
            ),
          ),

          // BOTÓN
          if (onTap != null)
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Ver",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _text(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 13,
        ),
      ),
    );
  }
}
