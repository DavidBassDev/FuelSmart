import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/form_row.dart';

class RefuelingForm extends StatelessWidget {
  final TextEditingController totalGallons;
  final TextEditingController totalMoney;
  final TextEditingController odometer;
  final TextEditingController ticketNumber;
  final TextEditingController comment;

  const RefuelingForm({
    super.key,
    required this.totalGallons,
    required this.totalMoney,
    required this.odometer,
    required this.ticketNumber,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormRow(
          label: 'Total Galones',
          icon: Icons.local_gas_station,
          controller: totalGallons,
        ),
        FormRow(
          label: 'Número factura',
          icon: Icons.attach_money,
          controller: ticketNumber,
        ),
        FormRow(label: 'Odómetro', icon: Icons.speed, controller: odometer),
        FormRow(
          label: 'Total \$\$\$',
          icon: Icons.attach_money,
          controller: totalMoney,
        ),
        FormRow(
          label: 'Comentario',
          icon: Icons.description,
          controller: comment,
        ),
      ],
    );
  }
}
