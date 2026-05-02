import 'package:flutter/material.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/features/users/widgets/carousel_widget_driver.dart';
import 'package:fuel_smart/features/vehicles/widgets/card_admin_vehicle_driver.dart';
import 'package:provider/provider.dart';

class DriverUserScreen extends StatelessWidget {
  const DriverUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLogged || auth.user == null || auth.token == null) {
      return const Scaffold(body: Center(child: Text("Token inválido")));
    }

    final User user = auth.user!;
    final token = auth.token!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 HEADER
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Bienvenido ${user.nombre}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis, // 🔥 evita overflow
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      user.rol ?? '',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                //CARD VEHICULO
                const CardAdminVehicleDriver(),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      'Acciones',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 22,
                      height: 22,
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
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  height: 170,
                  child: CarouselWidgetDriver(token: token),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
