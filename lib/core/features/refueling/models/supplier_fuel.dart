class SupplierFuel {
  final int supplierId;
  final String nameSupplier;
  final double? authorizedGallons;
  final double? consumedGallons;

  SupplierFuel({
    required this.supplierId,
    required this.nameSupplier,
    this.authorizedGallons,
    this.consumedGallons,
  });

  factory SupplierFuel.fromJson(Map<String, dynamic> json) {
    return SupplierFuel(
      supplierId: json['id_proveedor'],
      nameSupplier: json['nombre_proveedor'] ?? '',

      authorizedGallons: json['galones_autorizados'] != null
          ? double.parse(json['galones_autorizados'].toString())
          : null,
      consumedGallons: json['galones_consumidos'] != null
          ? double.parse(json['galones_consumidos'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_proveedor': supplierId,
      'nombre_proveedor': nameSupplier,
      'galones_autorizados': authorizedGallons,
      'galones_consumidos': consumedGallons,
    };
  }
}
