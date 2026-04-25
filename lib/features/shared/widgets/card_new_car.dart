import 'package:flutter/material.dart';

class CardNewCar extends StatelessWidget {
  final String placa;
  final String tipoVehiculo;
  final double rendimientoTeorico;
  final String centroOperacion;
  final String usuario;

  final VoidCallback? onTap;

  const CardNewCar({
    super.key,
    required this.placa,
    required this.tipoVehiculo,
    required this.rendimientoTeorico,
    required this.centroOperacion,
    required this.usuario,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF6E2C3E), width: 2),
      ),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              /// INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// PLACA
                    Text(
                      placa,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// TIPO VEHICULO
                    Text(
                      tipoVehiculo,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: 8),

                    /// RENDIMIENTO
                    Text(
                      "Rendimiento teórico: $rendimientoTeorico",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const SizedBox(height: 4),

                    /// CENTRO OPERACION
                    Text(
                      "Centro: $centroOperacion",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const SizedBox(height: 4),

                    /// USUARIO
                    Text(
                      "Usuario: $usuario",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              /// IMAGEN (opcional)
              Image.asset(
                "assets/images/logoPluxee.png",
                width: 80,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
