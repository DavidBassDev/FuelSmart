import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/clients/models/client.dart';

class ClientService {
  final ApiService api = ApiService();

  Future<List<Client>> getClient() async {
    final response = await api.get("clients");

    return (response as List).map((item) => Client.fromJson(item)).toList();
  }
}
