import 'package:fuel_smart/core/api/api_service.dart';

class VehicleService {
  final ApiService api = ApiService();

  Future creteNewRefueling(String token, Map<String, dynamic> data) async {
    return await api.postWithToken("vehicles/refueling", data, token);
  }
}
