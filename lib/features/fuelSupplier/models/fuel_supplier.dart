class FuelSupplier {
  final int idFuelSupplier;
  final String nameFuelSupplier;

  FuelSupplier({required this.idFuelSupplier, required this.nameFuelSupplier});

  factory FuelSupplier.fromJson(Map<String, dynamic> json) {
    return FuelSupplier(
      idFuelSupplier: json['id_proveedor'],
      nameFuelSupplier: json['nombre_proveedor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_proveedor': idFuelSupplier,
      'nombre_proveedor': nameFuelSupplier,
    };
  }
}
