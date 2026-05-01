import 'package:fuel_smart/core/api/api_service.dart';

class FeaturesService {
  final ApiService api = ApiService();

  //TRAER VEHICULOS QUE ESTAN BAJO DE COMBUSTIBLE
  Future<dynamic> getLowFuelVehicles(String token) async {
    return await api.getWithToken("api/dashboard/LowFuelVehicles", token);
  }
}
