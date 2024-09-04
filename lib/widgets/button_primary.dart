import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/riverpod/timer.dart';

class ButtonPrm extends ConsumerStatefulWidget {
  const ButtonPrm({
    super.key,
  });

  @override
  ButtonPrmState createState() => ButtonPrmState();
}

class ButtonPrmState extends ConsumerState<ButtonPrm> {
  bool isTapped = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = ref.watch(timerProvider)?.isRunning ?? false;
    return GestureDetector(
      onTap: () {
        if (isRunning) {
          ref.read(timerProvider.notifier).stopTimer();
        } else {
          ref.read(timerProvider.notifier).startTimer();
        }
      },
      onTapDown: (details) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isTapped = false;
        });
      },
      child: isRunning
          ? Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2.0)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ))
          : Container(
              decoration: BoxDecoration(
                color: const Color(0xFF68d0ad),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  !isTapped
                      ? BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(
                              0, 4), // horizontal and vertical offset
                        )
                      : const BoxShadow(),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              child: const Text(
                "Plant",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
    );
  }
}
