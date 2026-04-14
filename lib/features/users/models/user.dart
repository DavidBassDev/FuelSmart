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
      id: json["id_usuario"] ?? 0,
      nombre: json["nombre_completo"] ?? "",
      rol: json["rol"] ?? 'errorAca',
      idVehicle: json["id_vehiculo"] ?? "errorAca",
      placa: json["placa"] ?? 'Todas',
      nombreProyecto: json["nombre"] ?? 'testNombreProyecto',
    );
  }
}
