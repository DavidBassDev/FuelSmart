import 'package:flutter/material.dart';
import 'package:fuel_smart/core/providers/themee_provider.dart';
import 'package:provider/provider.dart';

class CardAdminOperation extends StatelessWidget {
  const CardAdminOperation({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var asset = "assets/images/car_check.png";
    if (themeProvider.type == AppThemeType.beige) {
      asset = "assets/images/car_check_white.png";
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSurface,
          width: 3,
        ),
      ),
      color: Theme.of(context).colorScheme.primary,
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
                  "Administrar\nMi operación",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Image.asset(asset, width: 120, fit: BoxFit.contain),
            ],
          ),
        ),
      ),
    );
  }
}
