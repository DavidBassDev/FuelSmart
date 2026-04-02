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
}
