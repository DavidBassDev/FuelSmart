import 'dart:io';
import 'package:fuel_smart/core/api/api_service.dart';

class RefuelingService {
  final ApiService api = ApiService();

  Future createNewRefueling(
    String token,
    Map<String, dynamic> data,
    File? image,
  ) async {
    return await api.postMultipartWithToken(
      "refueling/refueling",
      data,
      token,
      image,
    );
  }

  //ver repostaje caja menor
  Future seeRefuelingPC(String token, String idRefueling) async {
    return await api.getWithToken("refueling/pettycash/$idRefueling", token);
  }

  //ver cantidad galones consumidos placa y mes
  Future getGallonsConsumed(String token, int vehicleId, int month) async {
    return await api.getWithToken(
      "refueling/totalByMonth?vehiculo_id=$vehicleId&month=$month",
      token,
    );
  }

  //VEHICULOS Y CONSUMOS POR CLIENTE
  Future getVehiclesWithGallonsByClient(
    String token,
    int clientId,
    int month,
  ) async {
    return await api.getWithToken(
      "refueling/vehiclesByClient?id_cliente=$clientId&month=$month",
      token,
    );
  }
}
