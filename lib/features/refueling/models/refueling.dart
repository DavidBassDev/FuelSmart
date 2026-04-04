class Refueling {
  final int refuelingId;
  final int supplierId;
  final int userId;
  final int vehicleId;
  final DateTime refuelingDate;
  final double suppliedGallons;
  final double cost;
  final String refuelingType;
  final String? ticketSerial;
  final String? refuelingImage;
  final String? comment;
  final double odometer;
  static const _sentinel =
      Object(); //un sentinela o marcador, para manejar los null desde la bd
  Refueling({
    required this.refuelingId,
    required this.supplierId,
    required this.userId,
    required this.vehicleId,
    required this.refuelingDate,
    required this.suppliedGallons,
    required this.cost,
    required this.refuelingType,
    this.ticketSerial,
    this.refuelingImage,
    this.comment,
    required this.odometer,
  });

  factory Refueling.fromJson(Map<String, dynamic> json) {
    return Refueling(
      refuelingId: json['id_repostaje'] ?? 0,
      supplierId: json['proveedor_id'] ?? 0,
      userId: json['usuario_id'] ?? 0,
      vehicleId: json['vehiculo_id'] ?? 0,

      refuelingDate: json['fecha_repostaje'] != null
          ? DateTime.parse(json['fecha_repostaje'])
          : DateTime.now(),

      suppliedGallons: double.parse(json['galones_suministrados']),
      cost: double.parse(json['valor_dinero']),

      refuelingType: json['tipo_repostaje'] ?? '',

      ticketSerial: json['numero_soporte'],
      refuelingImage: json['vaucher_url'],
      comment: json['comentario'],

      odometer: double.parse(json['odometro']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_repostaje': refuelingId,
      'proveedor_id': supplierId,
      'usuario_id': userId,
      'vehiculo_id': vehicleId,
      'fecha_repostaje': refuelingDate.toIso8601String(),
      'galones_suministrados': suppliedGallons,
      'valor_dinero': cost,
      'tipo_repostaje': refuelingType,
      'numero_soporte': ticketSerial,
      'vaucher_url': refuelingImage,
      'comentario': comment,
      'odometro': odometer,
    };
  }

  Refueling copyWith({
    int? refuelingId,
    int? supplierId,
    int? userId,
    int? vehicleId,
    DateTime? refuelingDate,
    double? suppliedGallons,
    double? cost,
    String? refuelingType,
    Object? ticketSerial = _sentinel,
    Object? refuelingImage = _sentinel,
    Object? comment = _sentinel,
    double? odometer,
  }) {
    return Refueling(
      refuelingId: refuelingId ?? this.refuelingId,
      supplierId: supplierId ?? this.supplierId,
      userId: userId ?? this.userId,
      vehicleId: vehicleId ?? this.vehicleId,
      refuelingDate: refuelingDate ?? this.refuelingDate,
      suppliedGallons: suppliedGallons ?? this.suppliedGallons,
      cost: cost ?? this.cost,
      odometer: odometer ?? this.odometer,
      refuelingType: refuelingType ?? this.refuelingType,
      ticketSerial: ticketSerial == _sentinel
          ? this.ticketSerial
          : ticketSerial as String?,
      refuelingImage: refuelingImage == _sentinel
          ? this.refuelingImage
          : refuelingImage as String?,
      comment: comment == _sentinel ? this.comment : comment as String?,
    );
  }
}
