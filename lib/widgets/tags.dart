import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timer_app/widgets/settings.dart';

class TimerTag extends ConsumerWidget {
  const TimerTag({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(30, 255, 255, 255),
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          showBarModalBottomSheet(
              context: context,
              expand: false,
              builder: (context) => Settings());
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 150,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey.shade400),
                ),
                const SizedBox(width: 10),
                const Text("Mathematics II",
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ));
  }
}
