import 'package:flutter/material.dart';

class CarouselFunctions extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const CarouselFunctions({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: 45),
          ),
          SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
