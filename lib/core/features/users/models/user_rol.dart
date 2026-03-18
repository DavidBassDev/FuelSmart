class UserRol {
  final int rolId;
  final String rolName;

  UserRol({required this.rolId, required this.rolName});

  factory UserRol.fromJson(Map<String, dynamic> json) {
    return UserRol(rolId: json['id_rol'], rolName: json['nombre'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id_rol': rolId, 'nombre': rolName};
  }
}
