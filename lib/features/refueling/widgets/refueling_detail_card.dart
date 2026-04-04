import 'package:flutter/material.dart';
import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/refueling/models/refueling.dart';

final baseUrl = ApiService.baseUrl;

class RefuelingDetailCard extends StatelessWidget {
  final Refueling refueling;

  const RefuelingDetailCard({super.key, required this.refueling});

  @override
  Widget build(BuildContext context) {
    final imageUrl = "$baseUrl${refueling.refuelingImage}";
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// FECHA
            Text(
              "Fecha: ${refueling.refuelingDate}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// GALONES
            _item("Galones", refueling.suppliedGallons.toString()),

            /// VALOR
            _item("Valor total", "\$${refueling.cost}"),

            /// ODOMETRO
            _item("Odómetro", refueling.odometer.toString()),

            /// TICKET
            if (refueling.ticketSerial?.isEmpty ??
                refueling.ticketSerial == 'noTicket')
              _item("Soporte", refueling.ticketSerial.toString()),

            const SizedBox(height: 10),

            /// COMENTARIO
            const Text(
              "Comentario:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(refueling.comment!),

            const SizedBox(height: 15),

            /// IMAGEN
            if (refueling.refuelingImage != null)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Image.network(imageUrl, fit: BoxFit.contain),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
