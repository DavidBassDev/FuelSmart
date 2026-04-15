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
  List<User> usersDrivers = [];
  bool isLoading = true;
  bool _loaded = false;

  //estado por defecto
  String selectedRole = 'conductor';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      loadUsers(selectedRole);
      _loaded = true;
    }
  }

  Future<void> loadUsers(String selectedRole) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.token == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    final userService = UserService();

    final response = await userService.getUsersByRole(
      auth.token!,
      selectedRole,
    );

    if (!mounted) return;

    setState(() {
      usersDrivers = (response['users'] as List)
          .map((u) => User.fromJson(u))
          .toList();
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
                  PillBtnPersonalizated(
                    text: 'Conductores',
                    selected: selectedRole == 'conductor',
                    onTap: () {
                      if (selectedRole != 'conductor') {
                        setState(() {
                          selectedRole = 'conductor';
                        });
                        loadUsers('conductor');
                      }
                    },
                  ),

                  const SizedBox(width: 15),

                  PillBtnPersonalizated(
                    text: 'Supervisores',
                    selected: selectedRole == 'supervisor',
                    onTap: () {
                      if (selectedRole != 'supervisor') {
                        setState(() {
                          selectedRole = 'supervisor';
                        });
                        loadUsers('supervisor');
                      }
                    },
                  ),

                  const SizedBox(width: 15),

                  PillBtnPersonalizated(
                    text: 'Administradores',
                    selected: selectedRole == 'admin',
                    onTap: () {
                      if (selectedRole != 'admin') {
                        setState(() {
                          selectedRole = 'admin';
                        });
                        loadUsers('admin');
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : usersDrivers.isEmpty
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
                      itemCount: usersDrivers.length,
                      separatorBuilder: (_, __) =>
                          const DividerPersonalizated(thicknessSize: 1),
                      itemBuilder: (context, index) {
                        final user = usersDrivers[index];

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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF552235),
                            ),
                            child: const Text(
                              "Ver",
                              style: TextStyle(color: Colors.white),
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
