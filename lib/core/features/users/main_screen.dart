import 'package:flutter/material.dart';
import 'package:fuel_smart/core/features/users/carousel_widget.dart';
import 'package:fuel_smart/core/widgets/card_admin_operation.dart';

class MainScreen extends StatelessWidget {
  final String userName;
  final String rol;
  final String token;
  const MainScreen({
    super.key,
    required this.rol,
    required this.userName,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(height: 90),
                    Expanded(
                      child: Text(
                        'Bienvenido $userName!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        rol,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const CardAdminOperation(),
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
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(height: 120, child: CarouselWidget(token: token)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
