class Vehicle {
  final int vehicleId;
  final int userId;
  final int? fuelSupplierId;
  final String plate;
  final double teoricPerformance;
  final double actualPerformance;
  final int typeOfVehicle;
  final double avaliableFuel;
  final bool state;
  final DateTime creationDate;
  final DateTime updateDate;
  final int createBy;

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
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleId: json['id_vehiculo'] ?? 0,
      userId: json['usuario_id'] ?? 0,
      fuelSupplierId: json['proveedor_id'],
      plate: json['placa'] ?? '',

      teoricPerformance:
          (json['rendimiento_teorico'] as num?)?.toDouble() ?? 0.0,

      actualPerformance: (json['rendimiento'] as num?)?.toDouble() ?? 0.0,

      typeOfVehicle: json['tipo_vehiculo_id'] ?? 0,

      avaliableFuel: (json['cupo_combustible'] as num?)?.toDouble() ?? 0.0,

      state: json['estado'] ?? true,

      creationDate:
          DateTime.tryParse(json['fecha_creacion'] ?? '') ?? DateTime.now(),

      updateDate:
          DateTime.tryParse(json['fecha_actualizacion'] ?? '') ??
          DateTime.now(),

      createBy: json['creado_por'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id_vehiculo': vehicleId,
      'usuario_id': userId,
      'placa': plate,
      'rendimiento_teorico': teoricPerformance,
      'rendimiento': actualPerformance,
      'tipo_vehiculo_id': typeOfVehicle,
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

  /// 🔄 CopyWith (con marker para nullables)
  Vehicle copyWith({
    int? vehicleId,
    int? userId,
    Object? fuelSupplierId = _marker,
    String? plate,
    double? teoricPerformance,
    double? actualPerformance,
    int? typeOfVehicle,
    double? avaliableFuel,
    bool? state,
    DateTime? creationDate,
    DateTime? updateDate,
    int? createBy,
  }) {
    return Vehicle(
      vehicleId: vehicleId ?? this.vehicleId,
      userId: userId ?? this.userId,
      fuelSupplierId: fuelSupplierId == _marker
          ? this.fuelSupplierId
          : fuelSupplierId as int?,
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

  static const _marker = Object();
}
