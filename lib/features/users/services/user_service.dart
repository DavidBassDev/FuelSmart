import 'package:fuel_smart/core/api/api_service.dart';

class UserService {
  final ApiService api = ApiService();

  Future changePassword(String token, Map<String, dynamic> data) async {
    return await api.putWithToken("auth/changepassword", data, token);
  }

  Future getUsers(String token) async {
    return await api.getWithToken("users/listUsers", token);
  }
}
