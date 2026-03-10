import 'package:fuel_smart/core/services/api_service.dart';

class AuthService {
  final ApiService api = ApiService();

  Future login(String email, String password) async {
    return await api.post("auth/login", {
      "correo_electronico": email,
      "password": password,
    });
  }
}
