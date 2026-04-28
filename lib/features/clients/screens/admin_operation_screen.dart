import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/users/screens/widgets/pending_carousel_widget.dart';
import 'package:provider/provider.dart';

class AdminOperationScreen extends StatelessWidget {
  const AdminOperationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLogged || auth.user == null || auth.token == null) {
      return const Scaffold(body: Center(child: Text("Token inválido")));
    }

    final User user = auth.user!;
    final token = auth.token!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Administrar operación", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Icon(Icons.local_shipping_outlined),
              Text('Selecciona un cliente para administrar los vehiculos'),
            ],
          ),
          DividerPersonalizated(thicknessSize: 1),
          SizedBox(height: 20),
          Text(
            'Pendientes',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_right,
                color: Theme.of(context).colorScheme.primary,
                size: 18,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(height: 320, child: PendingCarouselWidget(token: token)),
          DividerPersonalizated(thicknessSize: 1),
          //AGREGAR PILLS DE CLIENTE Y CANTIDAD VEHICULOS
        ],
      ),
    );
  }
}
