import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerState {
  final int totalSeconds;
  final bool isRunning;
  final double percent;
  final int initialDuration;

  TimerState(
      {required this.totalSeconds,
      required this.isRunning,
      required this.initialDuration,
      required this.percent});

  TimerState copyWith(
      {int? totalSeconds,
      bool? isRunning,
      int? initialDuration,
      double? percent}) {
    return TimerState(
        totalSeconds: totalSeconds ?? this.totalSeconds,
        isRunning: isRunning ?? this.isRunning,
        initialDuration: initialDuration ?? this.initialDuration,
        percent: percent ?? this.percent);
  }
}

final durationProvider = StateProvider<int>((ref) => 5);
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState?>((ref) {
  return TimerNotifier(ref);
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier(this.ref)
      : super(TimerState(
            totalSeconds: ref.read(durationProvider),
            isRunning: false,
            initialDuration: ref.read(durationProvider),
            percent: 100));

  final Ref ref;
  Timer? _timer;

  void startTimer() {
    if (!state.isRunning) {
      state = state.copyWith(isRunning: true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (state.totalSeconds > 0) {
          final percent = (state.totalSeconds / state.initialDuration) * 100;
          state = state.copyWith(
              totalSeconds: state.totalSeconds - 1, percent: percent);
          
        } else {
          stopTimer();
        }
      });
    }
  }

  void stopTimer() {
    _timer?.cancel();
    state = state.copyWith(
        totalSeconds: ref.read(durationProvider),
        isRunning: false,
        initialDuration: ref.read(durationProvider),
        percent: 100);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
