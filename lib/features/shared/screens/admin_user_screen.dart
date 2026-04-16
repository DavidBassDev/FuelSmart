import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/shared/widgets/card_admin_user.dart';
import 'package:fuel_smart/features/shared/widgets/tip_admin_users.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/users/screens/admin_users_screen.dart';
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        centerTitle: true,
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
          DividerPersonalizated(thicknessSize: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, // PARA QUE SE AJUSTE LA DISTRIBUCION

            children: [
              SizedBox(height: 30),
              Icon(
                Icons.person,
                color: Color.fromARGB(255, 35, 35, 35),
                size: 80,
              ),
              SizedBox(width: 20),
              Text(
                user.nombre,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              SizedBox(width: 40),
              Text(
                user.rol ?? 'dintwork',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          DividerPersonalizated(thicknessSize: 1),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceAround, // PARA QUE SE AJUSTE LA DISTRIBUCION
              children: [
                Text(
                  'Administrar usuarios y roles',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Icon(Icons.groups_3_outlined, color: Colors.black, size: 80),
              ],
            ),
          ),
          DividerPersonalizated(thicknessSize: 1),
          const SizedBox(height: 5),
          CardAdminUser(
            icon: Icons.contact_emergency_rounded,
            titulo: 'Ver usuarios creados',
            descripcion: 'Ver y editar usuarios \n creados en el sistema',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SeeUsersScreen()),
              );
            },
            nameButtom: 'Ir',
          ),
          DividerPersonalizated(thicknessSize: 1),
          CardAdminUser(
            icon: Icons.person_add_alt_1,
            titulo: 'Crear usuario',
            descripcion:
                'Crear un usuario con rol \n administrador,coordinador o conductor',
            onPressed: () {},
            nameButtom: 'Crear',
          ),
          DividerPersonalizated(thicknessSize: 1),
          TipAdminUsers(),
        ],
      ),
    );
  }
}
