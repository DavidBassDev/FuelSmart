class FuelAssignment {
  final int assignmentId;
  final int vehicleId;
  final int supplierId;
  final double authorizedGallons;
  final DateTime date;
  final int? createdBy;
  final String? comment;

  const FuelAssignment({
    required this.assignmentId,
    required this.vehicleId,
    required this.supplierId,
    required this.authorizedGallons,
    required this.date,
    this.createdBy,
    this.comment,
  });
  static const _sentinela = Object();

  // JSON A OBJETO
  factory FuelAssignment.fromJson(Map<String, dynamic> json) {
    return FuelAssignment(
      assignmentId: json['id_asignacion'] ?? 0,
      vehicleId: json['vehiculo_id'] ?? 0,
      supplierId: json['proveedor_id'] ?? 0,
      authorizedGallons:
          (json['galones_autorizados'] as num?)?.toDouble() ?? 0.0,
      date: DateTime.tryParse(json['fecha'] ?? '') ?? DateTime.now(),
      createdBy: json['creado_por'],
      comment: json['comentario'],
    );
  }

  // parseo a JSON
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id_asignacion': assignmentId,
      'vehiculo_id': vehicleId,
      'proveedor_id': supplierId,
      'galones_autorizados': authorizedGallons,
      'fecha': date.toIso8601String(),
    };

    if (createdBy != null) {
      data['creado_por'] = createdBy;
    }
    if (comment != null) {
      data['comentario'] = comment;
    }

    return data;
  }

  FuelAssignment copyWith({
    int? assignmentId,
    int? vehicleId,
    int? supplierId,
    double? authorizedGallons,
    DateTime? date,
    Object? createdBy = _sentinela,
    Object? comment = _sentinela,
  }) {
    return FuelAssignment(
      assignmentId: assignmentId ?? this.assignmentId,
      vehicleId: vehicleId ?? this.vehicleId,
      supplierId: supplierId ?? this.supplierId,
      authorizedGallons: authorizedGallons ?? this.authorizedGallons,
      date: date ?? this.date,
      createdBy: createdBy == _sentinela ? this.createdBy : createdBy as int?,
      comment: comment == _sentinela ? this.comment : comment as String?,
    );
  }
}
