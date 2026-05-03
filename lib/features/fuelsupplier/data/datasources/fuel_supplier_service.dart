import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/fuelsupplier/data/models/fuel_supplier.dart';

class FuelSupplierService {
  final ApiService api = ApiService();

  Future<List<FuelSupplier>> getFuelSupplier(String token) async {
    final response = await api.getWithToken('fuelSupplier', token);
    return (response as List)
        .map((item) => FuelSupplier.fromJson(item))
        .toList();
  }
}
