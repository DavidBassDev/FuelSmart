import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/refueling/models/refueling.dart';
import 'package:fuel_smart/features/refueling/models/refueling_list_item.dart';

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
  Future<Refueling> seeRefuelingPC(String token, String idRefueling) async {
    final response = await api.getWithToken(
      "refueling/pettycash/$idRefueling",
      token,
    );

    return Refueling.fromJson(response);
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

  //TRAER LISTA DE CONSUMOS DE UNA PLACA
  Future<List<RefuelingListItem>> getVehiclesWithGallonsList(
    String token,
    int vehicleId,
  ) async {
    final response = await api.getWithToken(
      "refueling/refuelingPlate?vehiculo_id=$vehicleId",
      token,
    );
    final body = response is Map ? response : response.data;

    if (body == null || body['data'] == null) {
      debugPrint("Respuesta inválida: $body");
      return [];
    }
    print('vehiculeId es $vehicleId');

    final List data = body['data'];

    debugPrint("RESPONSE COMPLETO: ${response.toString()}");

    return data.map((e) => RefuelingListItem.fromJson(e)).toList();
  }

  //CREAR SOLICITUD AUMENTO GALONES
  Future createFuelRequest(
    String token, {
    required int idVehiculo,
    required int idProveedor,
    required double galones,
    required String comentario,
    required int solicitadoPor,
  }) async {
    final data = {
      "id_vehiculo": idVehiculo,
      "id_proveedor": idProveedor,
      "galones_solicitados": galones,
      "comentario": comentario,
      "solicitado_por": solicitadoPor,
    };

    debugPrint("BODY REQUEST: $data");

    final response = await api.postWithToken(
      "api/fuelrequest/fuel-request", //ruta
      data,
      token,
    );

    debugPrint("RESPONSE REQUEST: $response");

    return response;
  }

  // TRAER SOLICITUDES PENDIENTES
  Future<List<dynamic>> getPendingFuelRequests(String token) async {
    final response = await api.getWithToken(
      "api/fuelrequest/pendingRequests",
      token,
    );

    final body = response is Map ? response : response.data;

    if (body == null || body['data'] == null) {
      debugPrint("Respuesta inválida: $body");
      return [];
    }

    final List data = body['data'];

    debugPrint("SOLICITUDES: $data");

    return data;
  }

  // TRAER SOLICITUDES PENDIENTES PARA EL CONDUCTOR
  Future<List<dynamic>> getMyFuelRequest(String token) async {
    final response = await api.getWithToken(
      "api/fuelrequest/mypendingRequests",
      token,
    );

    final body = response is Map ? response : response.data;

    if (body == null || body['data'] == null) {
      debugPrint("Respuesta inválida: $body");
      return [];
    }

    final List data = body['data'];

    debugPrint("SOLICITUD: $data");

    return data;
  }

  //APROBAR O RECHAZAR SOLICITUD
  Future updateFuelRequestStatus(
    String token, {
    required int idSolicitud,
    required String estado, //
    required int respondidoPor,
  }) async {
    final data = {
      "id_solicitud": idSolicitud,
      "estado": estado,
      "respondido_por": respondidoPor,
    };

    debugPrint("BODY UPDATE STATUS: $data");

    final response = await api.putWithToken(
      "api/fuelrequest/updateFuelRequestStatus",
      data,
      token,
    );

    debugPrint("RESPONSE UPDATE STATUS: $response");

    return response;
  }

  //  AUMENTAR CUPO DIRECTO
  Future addFuelToVehicle(
    String token, {
    required int idVehiculo,
    required double galones,
  }) async {
    final data = {"id_vehiculo": idVehiculo, "galones": galones};

    debugPrint("BODY ADD FUEL: $data");

    final response = await api.postWithToken(
      "api/fuelrequest/addFuel",
      data,
      token,
    );

    debugPrint("RESPONSE ADD FUEL: $response");

    return response;
  }
}
