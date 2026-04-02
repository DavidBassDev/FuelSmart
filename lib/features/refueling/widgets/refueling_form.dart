import 'package:flutter/material.dart';
import 'package:fuel_smart/core/widgets/form_row.dart';

class RefuelingForm extends StatelessWidget {
  const RefuelingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FormRow(label: 'Fecha Repostaje', icon: Icons.calendar_today),
        FormRow(label: 'Total Galones', icon: Icons.local_gas_station),
        FormRow(label: 'Nombre EDS', icon: Icons.qr_code), //CAMBIAR
        FormRow(label: 'Justificación uso caja menor', icon: Icons.description),
        FormRow(
          label: 'Número factura',
          icon: Icons.attach_money,
        ), //cambiar icon
        FormRow(label: 'Odómetro', icon: Icons.attach_money), //cambiar icon
        FormRow(label: 'Total \$\$\$', icon: Icons.attach_money),
      ],
    );
  }
}
