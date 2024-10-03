import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const CategoryIcon(
      {super.key,
      required this.icon,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }
}
