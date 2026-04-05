import 'package:flutter/material.dart';

class PendingCarouselFunctions extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const PendingCarouselFunctions({
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
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            child: Icon(icon, color: Colors.black, size: 80),
          ),
          SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
