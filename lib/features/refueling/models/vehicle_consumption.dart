class VehicleConsumption {
  final String placa;
  final double totalGalones;

  VehicleConsumption({required this.placa, required this.totalGalones});

  factory VehicleConsumption.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return VehicleConsumption(
      placa: json['placa'] ?? '',
      totalGalones: toDouble(json['total_galones']),
    );
  }
}
