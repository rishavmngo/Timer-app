import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timer_app/riverpod/timer.dart';
import 'package:timer_app/utils/timerDisplay.dart';
import 'package:timer_app/widgets/settings.dart';

class TimerTime extends ConsumerWidget {
  const TimerTime({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerValue = ref.watch(timerProvider)?.totalSeconds ?? 1;
    return GestureDetector(
      onTap: () {
        //ref.read(timerProvider.notifier).stopTimer();

        showBarModalBottomSheet(
            context: context,
            expand: false,
            builder: (context) => const Settings());
      },
      child: Text(FormatSecondsToMMSS(timerValue),
          style: Theme.of(context).textTheme.headlineLarge),
    );
  }
}
