import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/vehicles/models/vehicle.dart';

class VehicleService {
  final ApiService api = ApiService();

  Future getMyVehicles(String token) async {
    return await api.getWithToken("vehicles/listVehicles", token);
  }

  //LISTAR TODOS LOS VEHICULOS
  Future<List<Vehicle>> getVehicles() async {
    final response = await api.get("vehicles/listAllVehicles");
    return (response as List).map((item) => Vehicle.fromJson(item)).toList();
  }

  //TRAER VEHICULO EN ESPECIFICO
  Future<Vehicle> getVehicle(int idVehicle) async {
    final response = await api.get("vehicles/getVehicle/$idVehicle");
    return Vehicle.fromJson(response['data']);
  }

  //CREAR VEHICULO
  Future<dynamic> createVehicle(String token, Map<String, dynamic> data) async {
    final response = await api.postWithToken("vehicles/create", data, token);
    return response;
  }

  //SUSPENDER VEHICULO
  Future<dynamic> inactivateVehicle(String token, int idVehiculo) async {
    final data = {"id_vehiculo": idVehiculo};

    final response = await api.putWithToken(
      "vehicles/inactivateVehicle",
      data,
      token,
    );

    return response;
  }

  //ACTIVAR VEHICULO
  Future<dynamic> activateVehicle(String token, int idVehiculo) async {
    final data = {"id_vehiculo": idVehiculo};

    final response = await api.putWithToken(
      "vehicles/activateVehicle",
      data,
      token,
    );

    return response;
  }
}
