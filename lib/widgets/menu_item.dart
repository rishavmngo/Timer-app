import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final double width;
  final IconData icon;
  final String text;
  const MenuItem(
      {super.key, this.width = 12, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black54,
        ),
        SizedBox(width: width),
        Text(
          text,
          style: const TextStyle(color: Colors.black87),
        )
      ],
    );
  }
}
