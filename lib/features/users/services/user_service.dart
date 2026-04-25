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

  //Actualizar usuario
  Future<dynamic> updateUser(String token, Map<String, dynamic> data) async {
    final response = await api.putWithToken("users/editUser", data, token);

    print('entra en metodo UpdateUser');
    return response;
  }

  //Inactivar usuario
  Future<dynamic> inactiveUser(String token, Map<String, dynamic> data) async {
    final response = await api.putWithToken(
      "users/inactivateUser",
      data,
      token,
    );

    print('entra en metodo inactivar usuario');
    return response;
  }

  //Crear usuario
  Future<dynamic> createUser(String token, Map<String, dynamic> data) async {
    final response = await api.postWithToken("users/register", data, token);

    print('entra en metodo crear usuario');
    return response;
  }
}
