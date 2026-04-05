import 'package:flutter/material.dart';
import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/refueling/models/refueling.dart';
import 'package:intl/intl.dart';

final baseUrl = ApiService.baseUrl;

class RefuelingDetailCard extends StatelessWidget {
  final Refueling refueling;

  const RefuelingDetailCard({super.key, required this.refueling});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0, //para quitar el cero que viene desde BD
    );
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
            Text(
              "Resumen repostaje",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),

            const SizedBox(height: 10),
            _item(
              "Fecha",
              DateFormat('yyyy-MM-dd').format(refueling.refuelingDate),
            ),
            _item("Galones", refueling.suppliedGallons.toString()),
            _item("Valor total", formatter.format(refueling.cost)),
            _item("Odómetro", refueling.odometer.toString()),

            if (refueling.ticketSerial?.isEmpty ??
                refueling.ticketSerial == 'noTicket')
              _item("Soporte", refueling.ticketSerial.toString()),

            const SizedBox(height: 10),

            // COMENTARIO
            Text(
              "Justificación uso caja menor:",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Text(refueling.comment!),

            const SizedBox(height: 15),
            DividerPersonalizated(thicknessSize: 1),

            // IMAGEN
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
                  borderRadius: BorderRadius.circular(15),

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
