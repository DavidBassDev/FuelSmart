import 'package:flutter/material.dart';

class PendingCarouselFunctions extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subtitle;
  final VoidCallback onPressed;

  const PendingCarouselFunctions({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.subtitle,
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
              color: Theme.of(context).colorScheme.onSecondary,
              shape: BoxShape.rectangle,
            ),
            child: Icon(icon, color: Colors.black, size: 80),
          ),
          SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
