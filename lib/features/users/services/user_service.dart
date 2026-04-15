import 'package:fuel_smart/core/api/api_service.dart';

class UserService {
  final ApiService api = ApiService();

  Future changePassword(String token, Map<String, dynamic> data) async {
    return await api.putWithToken("auth/changepassword", data, token);
  }

  Future getUsersByRole(String token, String rol) async {
    if (rol == 'conductor') {
      return await api.getWithToken("users/listDrivers", token);
      //ENDPOINT PARA USUARIOS SUPERVISORES
    } else if (rol == 'supervisor') {
      return await api.getWithToken("users/listSupervisor", token);
    }
    //ENDPOINT ADMINISTRADORES
    else {
      return await api.getWithToken("users/listAdmin", token);
    }
  }
}
