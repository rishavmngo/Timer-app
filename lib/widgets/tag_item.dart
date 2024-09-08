import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagItem extends ConsumerWidget {
  final String name;
  final bool isSelected;
  final Color textColor;
  final Color color;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  const TagItem(
      {super.key,
      required this.name,
      required this.color,
      this.textColor = Colors.black54,
      this.onPressed,
      this.onLongPress,
      this.isSelected = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
          onTap: onPressed,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isSelected
                    ? Colors.white38
                    : Colors.grey.shade400.withAlpha(80)),
            constraints: const BoxConstraints(
              maxWidth: 150,
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                  const SizedBox(width: 15),
                  Text(name,
                      style: TextStyle(
                          color: isSelected ? Colors.black87 : (textColor),
                          fontSize: 29,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          )),
    );
  }
}
