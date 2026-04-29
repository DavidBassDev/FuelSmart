class VehicleGallons {
  final int idVehiculo;
  final String placa;
  final String totalGalones;

  VehicleGallons({
    required this.idVehiculo,
    required this.placa,
    required this.totalGalones,
  });

  factory VehicleGallons.fromJson(Map<String, dynamic> json) {
    return VehicleGallons(
      idVehiculo: json['id_vehiculo'],
      placa: json['placa'] ?? '',
      totalGalones: json['total_galones'].toString(),
    );
  }
}
