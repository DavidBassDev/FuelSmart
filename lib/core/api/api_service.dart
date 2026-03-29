import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const ipLocal = "192.168.1.1";
  static const ipADV = "10.0.2.2";

  static final String baseUrl = "http://$ipADV:3000";

  /// GET sin token
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }

  /// POST sin token
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  ///  GET con token
  Future<dynamic> getWithToken(String endpoint, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }

  ///
  Future<dynamic> postWithToken(
    String endpoint,
    Map<String, dynamic> data,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }
}
