import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/shared/widgets/pill_btn_personalizated.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/users/services/user_service.dart';
import 'package:provider/provider.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  List<User> users = [];
  bool isLoading = true;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      loadUsers();
      _loaded = true;
    }
  }

  Future<void> loadUsers() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final userService = UserService();
    final response = await userService.gerCarDriverUsers(auth.token!);

    if (!mounted) return;

    setState(() {
      users = (response['users'] as List).map((u) => User.fromJson(u)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 30),
        ),
        title: Text(
          "Administrar usuarios",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PillBtnPersonalizated(text: 'Conductores'),
                  const SizedBox(width: 15),
                  PillBtnPersonalizated(text: 'Supervisores'),
                  const SizedBox(width: 15),
                  PillBtnPersonalizated(text: 'Administradores'),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : users.isEmpty
                  ? Center(
                      child: Text(
                        "No hay usuarios disponibles",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (_, __) =>
                          const DividerPersonalizated(thicknessSize: 1),
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ListTile(
                          leading: const Icon(Icons.person, size: 40),

                          title: Text(
                            user.nombre,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),

                          subtitle: Text(
                            "Placa: ${user.placa ?? 'sin dato'}\n"
                            "Cliente: ${user.nombreProyecto ?? 'Sede Principal'}",
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                          ),

                          trailing: ElevatedButton(
                            onPressed: () {
                              // para llevar a la ventana del usuario
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF552235),
                            ),
                            child: Text(
                              style: TextStyle(color: Colors.white),
                              "Ver",
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
