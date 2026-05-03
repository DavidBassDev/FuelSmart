import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/users/models/user_rol.dart';

class RoleService {
  final ApiService api = ApiService();

  Future<List<UserRol>> getRoles() async {
    final response = await api.get("roles");

    return (response as List).map((item) => UserRol.fromJson(item)).toList();
  }
}
