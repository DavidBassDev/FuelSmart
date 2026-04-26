import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/vehicles/models/type_of_vehicle.dart';

class VehicleTypeService {
  final ApiService api = ApiService();

  Future<List<TypeOfVehicle>> getList() async {
    final response = await api.get("vehicles/listVehiclesType");

    return (response as List)
        .map((item) => TypeOfVehicle.fromJson(item))
        .toList();
  }
}
