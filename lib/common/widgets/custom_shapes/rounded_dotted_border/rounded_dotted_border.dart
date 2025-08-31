import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RoundedRectDottedBorder extends StatelessWidget {
  const RoundedRectDottedBorder({super.key, required this.name, required this.icon});
  final String name ;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Center(
    child: DottedBorder(
      options: const RoundedRectDottedBorderOptions(
        dashPattern: [10, 5],
        strokeWidth: 2,
        radius: Radius.circular(16),
        color: Colors.indigo,
        padding: EdgeInsets.all(16),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}