import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagItem extends ConsumerWidget {
  final String name;
  final bool isSelected;
  final Color color;
  final VoidCallback? onPressed;
  const TagItem(
      {super.key,
      required this.name,
      required this.color,
      this.onPressed,
      this.isSelected = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: isSelected
                ? Colors.white38
                : Colors.grey.shade400.withAlpha(80),
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: onPressed,
          child: Container(
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
                          color: isSelected ? Colors.black87 : Colors.black54,
                          fontSize: 29,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          )),
    );
  }
}
