class Clients {
  final int? clientId;
  final String name;
  final int? cantidadPlacas;

  Clients({this.clientId, required this.name, this.cantidadPlacas});

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      clientId: json['id_cliente'],
      name: json['nombre'] ?? json['cliente'] ?? '',
      cantidadPlacas: json['cantidad_placas'] != null
          ? int.parse(json['cantidad_placas'].toString())
          : null,
    );
  }
}
