class User {
  final int userId;
  final String fullName;
  final String email;
  final bool state;
  final DateTime createdTime;
  final DateTime? lastAccess;
  final int? createdBy;
  final int? vehicleId;
  final int? clientId;
  final int rolId;

  const User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.state,
    required this.createdTime,
    this.lastAccess,
    this.createdBy,
    this.vehicleId,
    this.clientId,
    required this.rolId,
  });

  /// 🔄 JSON → Objeto
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id_usuario'] ?? 0,
      fullName: json['nombre_completo'] ?? '',
      email: json['correo_electronico'] ?? '',
      state: json['estado'] ?? true,

      createdTime:
          DateTime.tryParse(json['fecha_creacion'] ?? '') ?? DateTime.now(),

      lastAccess: json['fecha_ultimo_acceso'] != null
          ? DateTime.tryParse(json['fecha_ultimo_acceso'])
          : null,

      createdBy: json['creado_por'],
      vehicleId: json['vehiculo_id'],
      clientId: json['cliente_id'],
      rolId: json['rol_id'] ?? 0,
    );
  }

  /// 🔄 Objeto → JSON
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id_usuario': userId,
      'nombre_completo': fullName,
      'correo_electronico': email,
      'estado': state,
      'fecha_creacion': createdTime.toIso8601String(),
      'rol_id': rolId,
    };

    if (lastAccess != null) {
      data['fecha_ultimo_acceso'] = lastAccess!.toIso8601String();
    }
    if (createdBy != null) {
      data['creado_por'] = createdBy;
    }
    if (vehicleId != null) {
      data['vehiculo_id'] = vehicleId;
    }
    if (clientId != null) {
      data['cliente_id'] = clientId;
    }

    return data;
  }

  /// 🔄 CopyWith (nivel pro con marker)
  User copyWith({
    int? userId,
    String? fullName,
    String? email,
    bool? state,
    DateTime? createdTime,
    Object? lastAccess = _marker,
    Object? createdBy = _marker,
    Object? vehicleId = _marker,
    Object? clientId = _marker,
    int? rolId,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      state: state ?? this.state,
      createdTime: createdTime ?? this.createdTime,
      lastAccess: lastAccess == _marker
          ? this.lastAccess
          : lastAccess as DateTime?,
      createdBy: createdBy == _marker ? this.createdBy : createdBy as int?,
      vehicleId: vehicleId == _marker ? this.vehicleId : vehicleId as int?,
      clientId: clientId == _marker ? this.clientId : clientId as int?,
      rolId: rolId ?? this.rolId,
    );
  }

  static const _marker = Object();
}
