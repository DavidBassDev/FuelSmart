class Client {
  final int clientId;
  final String name;

  Client({required this.clientId, required this.name});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(clientId: json['id_cliente'], name: json['nombre'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id_cliente': clientId, 'nombre': name};
  }
}
