import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/clients/models/clients.dart';

class ClientService {
  final ApiService api = ApiService();

  Future<List<Clients>> getClient() async {
    final response = await api.get("clients");

    return (response as List).map((item) => Clients.fromJson(item)).toList();
  }

  Future<List<Clients>> getPlatesByClient({
    int? idCliente,
    required int rol,
    required String token, // 🔥 nuevo
  }) async {
    final response = await api.getWithToken(
      "clients/listPlates?rol=$rol${idCliente != null ? "&id_cliente=$idCliente" : ""}",
      token,
    );

    print("RESPONSE: $response");

    if (response == null || response['data'] == null) {
      return [];
    }

    final List data = response['data'];

    return data.map((item) => Clients.fromJson(item)).toList();
  }
}
