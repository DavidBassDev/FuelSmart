import 'package:flutter/material.dart';

class CardAdminOperation extends StatelessWidget {
  const CardAdminOperation({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF6E2C3E), width: 3),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          print("Abrir módulo");
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Administrar\nmi operación",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.black),

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Image.asset(
                "assets/images/car_check.png",
                width: 120,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
