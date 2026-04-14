class User {
  final int id;
  final String nombre;
  final String? rol;
  final String? placa;
  final String? nombreProyecto;

  User({
    required this.id,
    required this.nombre,
    this.rol,
    this.placa,
    this.nombreProyecto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id_usuario"] ?? 0,
      nombre: json["nombre_completo"] ?? "",
      rol: json["rol"],
      placa: json["placa"],
      nombreProyecto: json["nombre"],
    );
  }
}
