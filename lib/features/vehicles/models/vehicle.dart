class Vehicle {
  final int vehicleId;
  final int userId;
  final String? fuelSupplierId;
  final String plate;
  final double teoricPerformance;
  final double actualPerformance;
  final String typeOfVehicle;
  final double avaliableFuel;
  final bool state;
  final DateTime creationDate;
  final DateTime updateDate;
  final int createBy;
  final String? userName;

  const Vehicle({
    required this.vehicleId,
    required this.userId,
    this.fuelSupplierId,
    required this.plate,
    required this.teoricPerformance,
    required this.actualPerformance,
    required this.typeOfVehicle,
    required this.avaliableFuel,
    required this.state,
    required this.creationDate,
    required this.updateDate,
    required this.createBy,
    this.userName,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleId:
          int.tryParse(
            json['id_vehiculo']?.toString() ??
                json['vehicle_id']?.toString() ??
                json['id']?.toString() ??
                json['idVehicle']?.toString() ??
                '',
          ) ??
          0,

      userId: int.tryParse(json['usuario_id']?.toString() ?? '') ?? 0,

      fuelSupplierId: json['proveedor']?.toString() ?? '',

      plate: json['placa']?.toString() ?? '',

      teoricPerformance:
          double.tryParse(json['rendimiento_teorico']?.toString() ?? '') ?? 0.0,

      actualPerformance:
          double.tryParse(json['rendimiento']?.toString() ?? '') ?? 0.0,

      typeOfVehicle: json['tipo_vehiculo']?.toString() ?? '',

      avaliableFuel:
          double.tryParse(json['cupo_combustible']?.toString() ?? '') ?? 0.0,

      state: json['estado'] == null
          ? true
          : json['estado'] == true ||
                json['estado'].toString() == 'true' ||
                json['estado'].toString() == '1',

      creationDate:
          DateTime.tryParse(json['fecha_creacion']?.toString() ?? '') ??
          DateTime.now(),

      updateDate:
          DateTime.tryParse(json['fecha_actualizacion']?.toString() ?? '') ??
          DateTime.now(),

      createBy: int.tryParse(json['creado_por']?.toString() ?? '') ?? 0,
      userName: json['nombre_usuario']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id_vehiculo': vehicleId,
      'usuario_id': userId,
      'placa': plate,
      'rendimiento_teorico': teoricPerformance,
      'rendimiento': actualPerformance,
      'tipo_vehiculo': typeOfVehicle,
      'cupo_combustible': avaliableFuel,
      'estado': state,
      'fecha_creacion': creationDate.toIso8601String(),
      'fecha_actualizacion': updateDate.toIso8601String(),
      'creado_por': createBy,
    };

    if (fuelSupplierId != null) {
      data['proveedor_id'] = fuelSupplierId;
    }

    return data;
  }

  Vehicle copyWith({
    int? vehicleId,
    int? userId,
    String? fuelSupplierId,
    String? plate,
    double? teoricPerformance,
    double? actualPerformance,
    String? typeOfVehicle,
    double? avaliableFuel,
    bool? state,
    DateTime? creationDate,
    DateTime? updateDate,
    int? createBy,
  }) {
    return Vehicle(
      vehicleId: vehicleId ?? this.vehicleId,
      userId: userId ?? this.userId,
      fuelSupplierId: fuelSupplierId ?? this.fuelSupplierId,
      plate: plate ?? this.plate,
      teoricPerformance: teoricPerformance ?? this.teoricPerformance,
      actualPerformance: actualPerformance ?? this.actualPerformance,
      typeOfVehicle: typeOfVehicle ?? this.typeOfVehicle,
      avaliableFuel: avaliableFuel ?? this.avaliableFuel,
      state: state ?? this.state,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      createBy: createBy ?? this.createBy,
    );
  }
}
