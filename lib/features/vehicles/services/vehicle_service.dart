import 'package:fuel_smart/core/api/api_service.dart';

class VehicleService {
  final ApiService api = ApiService();

  Future getMyVehicles(String token) async {
    return await api.getWithToken("vehicles/listVehicles", token);
  }
}
