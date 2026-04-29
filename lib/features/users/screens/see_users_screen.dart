import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/shared/screens/users/see_user_screen.dart';
import 'package:fuel_smart/features/shared/widgets/pill_btn_personalizated.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/users/services/user_service.dart';
import 'package:provider/provider.dart';

class SeeUsersScreen extends StatefulWidget {
  const SeeUsersScreen({super.key});

  @override
  State<SeeUsersScreen> createState() => _SeeUsersScreen();
}

class _SeeUsersScreen extends State<SeeUsersScreen> {
  List<User> usersDrivers = [];
  bool isLoading = true;
  bool _loaded = false;

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

  Widget _buildUserItem(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.person,
            size: 40,
            color: Theme.of(context).colorScheme.error,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Placa: ${user.placa ?? 'sin dato'}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Cliente: ${user.nombreProyecto ?? 'Sede Principal'}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SeeUserScreen(userSelected: user),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Text("Ver", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
                        setState(() => selectedRole = 'conductor');
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
                        setState(() => selectedRole = 'supervisor');
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
                        setState(() => selectedRole = 'admin');
                        loadUsers('admin');
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            //LISTA
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
                        return _buildUserItem(user);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
