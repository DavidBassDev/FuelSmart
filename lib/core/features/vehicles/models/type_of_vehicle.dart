class TypeOfVehicle {
  final int typeOfVehicleId;
  final String name;

  TypeOfVehicle({required this.typeOfVehicleId, required this.name});

  // parseo json a objeto
  factory TypeOfVehicle.fromJson(Map<String, dynamic> json) {
    return TypeOfVehicle(
      typeOfVehicleId: json['id_tipovehiculo'],
      name: json['nombre'] ?? '',
    );
  }

  // parseo a json
  Map<String, dynamic> toJson() {
    return {'id_tipovehiculo': typeOfVehicleId, 'nombre': name};
  }
}
