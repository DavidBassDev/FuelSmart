import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:provider/provider.dart';

class AdminUserScreen extends StatelessWidget {
  const AdminUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (!auth.isLogged || auth.user == null || auth.token == null) {
      return const Scaffold(body: Center(child: Text("Token inválido")));
    }

    final User user = auth.user!;
    final name = user.nombre;
    print('probando nombre $name');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        title: Text(
          "Administrar usuarios y roles",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(height: 30),
              Icon(Icons.person, color: Colors.black, size: 80),
              SizedBox(width: 20),
              Text(user.nombre),

              SizedBox(width: 20),
              Text(user.rol ?? 'dintwork'),
            ],
          ),
          DividerPersonalizated(thicknessSize: 1),
          Center(child: Row(children: [Text('Administrar usuarios y roles')])),
        ],
      ),
    );
  }
}
