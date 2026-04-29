import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/auth_provider.dart';
import 'package:fuel_smart/core/widgets/dividerPersonalizated.dart';
import 'package:fuel_smart/features/clients/services/client_service.dart';
import 'package:fuel_smart/features/users/models/user.dart';
import 'package:fuel_smart/features/clients/models/clients.dart';
import 'package:fuel_smart/features/users/widgets/pending_carousel_widget.dart';
import 'package:provider/provider.dart';

class AdminOperationScreen extends StatefulWidget {
  const AdminOperationScreen({super.key});

  @override
  State<AdminOperationScreen> createState() => _AdminOperationScreenState();
}

class _AdminOperationScreenState extends State<AdminOperationScreen> {
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

  //METODO PARA TRAER LAS CANTIDADES DE PLACAS POR CLIENTE
  Future<void> loadPlatesClient() async {
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

    final clientService = ClientService();

    final response = await clientService.getPlatesByClient(rol: 1);

    if (!mounted) return;

    setState(() {
      platesClient = response;
      isLoading = false;
    });
  }

  Widget _buildClientItem(Clients client) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.business,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  "Cantidad de placas: ${client.cantidadPlacas ?? 0}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
            onPressed: () {
              // Aquí puedes navegar o cargar info
              print("Cliente seleccionado: ${client.name}");
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.local_shipping_outlined,
                  size: 40,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    'Selecciona un cliente para administrar los vehiculos',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            DividerPersonalizated(thicknessSize: 1),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Pendientes',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(width: 8),

            const SizedBox(height: 15),
            SizedBox(height: 225, child: PendingCarouselWidget(token: token)),
            DividerPersonalizated(thicknessSize: 1),
            //AGREGAR PILLS DE CLIENTE Y CANTIDAD VEHICULOS
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: platesClient.length,
              itemBuilder: (context, index) {
                return _buildClientItem(platesClient[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
