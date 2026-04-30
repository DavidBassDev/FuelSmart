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
        color: const Color(0xFF7B2D3B), // cambiar al color del tema
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧾 ICONO
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.receipt_long, size: 30),
          ),

          const SizedBox(width: 12),

          //INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text("Cantidad galones: ${item.galones.toStringAsFixed(2)}"),
                _text("Odómetro: ${currencyFormat.format(item.odometro)}"),
                _text("Valor: \$${currencyFormat.format(item.valor)}"),
                _text("Proveedor: ${item.tipo}"),
                _text("Fecha: ${dateFormat.format(item.fecha)}"),
              ],
            ),
          ),

          //funcion boton
          if (onTap != null)
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5A1F2A), //cambiar segun tema
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Ver"),
            ),
        ],
      ),
    );
  }

  Widget _text(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, //cambiar segun tema
          fontSize: 13,
        ),
      ),
    );
  }
}
