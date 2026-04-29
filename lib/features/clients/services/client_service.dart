import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/clients/models/clients.dart';

class ClientService {
  final ApiService api = ApiService();

  Future<List<Clients>> getClient() async {
    final response = await api.get("clients");

    return (response as List).map((item) => Clients.fromJson(item)).toList();
  }

  //Traer cantidad de placas por cliente
  Future<List<Clients>> getPlatesByClient({
    int? idCliente,
    required int rol,
  }) async {
    final response = await api.get2(
      "clients/listPlates",
      params: {"rol": rol, if (idCliente != null) "id_cliente": idCliente},
    );

    final List data = response['data'];

    return data.map((item) => Clients.fromJson(item)).toList();
  }
}
