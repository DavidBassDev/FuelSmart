import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/screens/admin_client_screen.dart';
import 'package:fuel_smart/features/clients/services/client_service.dart';
import 'package:fuel_smart/features/clients/widgets/build_client_item_widget.dart';
import 'package:fuel_smart/features/clients/models/clients.dart';
import 'package:provider/provider.dart';

class AdminVehiclesOperationScreen extends StatefulWidget {
  const AdminVehiclesOperationScreen({super.key});

  @override
  State<AdminVehiclesOperationScreen> createState() =>
      _AdminVehcilesOperationScreen();
}

class _AdminVehcilesOperationScreen
    extends State<AdminVehiclesOperationScreen> {
  List<Clients> platesClient = [];
  bool isLoading = true;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      loadPlatesClient();
      _loaded = true;
    }
  }

  // TRAER CANTIDAD DE PLACAS POR CLIENTE
  Future<void> loadPlatesClient() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (auth.token == null) {
      setState(() => isLoading = false);
      return;
    }

    setState(() => isLoading = true);

    final clientService = ClientService();
    final response = await clientService.getPlatesByClient(
      rol: 1,
      token: auth.token!, // 🔥 AQUÍ
    );

    if (!mounted) return;

    setState(() {
      platesClient = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (!auth.isLogged || auth.user == null || auth.token == null) {
      return const Scaffold(body: Center(child: Text("Token inválido")));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Administrar vehículos",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // HEADER
            Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Selecciona un cliente para administrar los vehículos',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),

            const DividerPersonalizated(thicknessSize: 1),
            const SizedBox(height: 20),

            /// LISTA CLIENTES
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: platesClient.length,
                      itemBuilder: (context, index) {
                        final client = platesClient[index];

                        return BuildClientItemWidget(
                          client: client,
                          onPressed: () {
                            //ir a pantalla del cliente
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AdminClientScreen(clientSelected: client),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const DividerPersonalizated(thicknessSize: 1),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
