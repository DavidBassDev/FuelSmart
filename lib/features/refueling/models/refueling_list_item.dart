class RefuelingListItem {
  final int id;
  final String tipo;
  final double galones;
  final double valor;
  final DateTime fecha;
  final double odometro;

  RefuelingListItem({
    required this.id,
    required this.tipo,
    required this.galones,
    required this.valor,
    required this.fecha,
    required this.odometro,
  });

  factory RefuelingListItem.fromJson(Map<String, dynamic> json) {
    return RefuelingListItem(
      id: json['id_repostaje'],
      tipo: json['tipo_repostaje'],
      galones: double.parse(json['galones_suministrados']),
      valor: double.parse(json['valor_dinero']),
      fecha: DateTime.parse(json['fecha_repostaje']),
      odometro: double.parse(json['odometro']),
    );
  }
}
