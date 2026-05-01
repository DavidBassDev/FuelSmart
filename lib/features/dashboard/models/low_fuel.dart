class LowFuelVehicle {
  final String placa;
  final double cupoCombustible;
  final double totalGalones;
  final String? clienteNombre;

  LowFuelVehicle({
    required this.placa,
    required this.cupoCombustible,
    required this.totalGalones,
    this.clienteNombre,
  });

  factory LowFuelVehicle.fromJson(Map<String, dynamic> json) {
    double parseToDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return LowFuelVehicle(
      placa: json['placa'] ?? '',
      cupoCombustible: parseToDouble(json['cupo_combustible']),
      totalGalones: parseToDouble(json['total_galones']),
      clienteNombre: json['cliente_nombre'],
    );
  }
}
