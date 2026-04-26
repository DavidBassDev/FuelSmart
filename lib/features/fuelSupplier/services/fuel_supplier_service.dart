import 'package:fuel_smart/core/api/api_service.dart';
import 'package:fuel_smart/features/fuelSupplier/models/fuel_supplier.dart';

class FuelSupplierService {
  final ApiService api = ApiService();

  Future<List<FuelSupplier>> getFuelSupplier() async {
    final response = await api.get("fuelSupplier");

    return (response as List)
        .map((item) => FuelSupplier.fromJson(item))
        .toList();
  }
}
