class User {
  final int id;
  final String nombre;
  final String? rol;
  final String? placa;
  final String? nombreProyecto;
  final String? idVehicle;

  User({
    required this.id,
    required this.nombre,
    this.rol,
    this.placa,
    this.nombreProyecto,
    this.idVehicle,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? json["id_usuario"] ?? 0,

      // 🔥 SOPORTA AMBOS CASOS
      nombre: json["nombre"] ?? json["nombre_completo"] ?? "nombre con error",

      rol: json["rol"] ?? 'errorAca',

      idVehicle: json["id_vehiculo"],
      placa: json["placa"],
      nombreProyecto: json["nombre_proyecto"],
    );
  }
}
