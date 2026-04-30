import 'package:fuel_smart/core/api/api_service.dart';

class TelemetryService {
  final ApiService api = ApiService();

  Future<dynamic> getTelemetry(String plate, String month, String year) async {
    return await api.get3(
      "api/telemetria/mensual?placa=$plate&mes=$month&anio=$year",
    );
  }
}
