import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const ipLocal = "192.168.1.7";
  static const ipADV = "10.0.2.2";

  static final String baseUrl = "http://$ipLocal:3000";

  /// GET sin token
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {"Content-Type": "application/json"},
    );
    return jsonDecode(response.body);
  }

  //
  Future<dynamic> get2(String endpoint, {Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: params?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    return jsonDecode(response.body);
  }

  //
  Future<dynamic> get3(String endpoint, {Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: params?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception("Error HTTP ${response.statusCode}: ${response.body}");
    }

    try {
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception("Error parseando JSON: ${response.body}");
    }
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

  //PUT CON TOKEN
  Future<dynamic> putWithToken(
    String endpoint,
    Map<String, dynamic> data,
    String token,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  ///  GET con token
  Future<dynamic> getWithToken(String endpoint, String token) async {
    print('$baseUrl/$endpoint');
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

  Future<dynamic> postMultipartWithToken(
    String endpoint,
    Map<String, dynamic> data,
    String token,
    File? image,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/$endpoint'),
    );

    //  Headers
    request.headers['Authorization'] = 'Bearer $token';

    //  Campos normales
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Imagen (opcional)
    if (image != null) {
      request.files.add(
        await http.MultipartFile.fromPath('imagen', image.path),
      );
    }

    //  Enviar
    var response = await request.send();

    final respStr = await response.stream.bytesToString();

    try {
      return jsonDecode(respStr);
    } catch (e) {
      return respStr;
    }
  }
}
