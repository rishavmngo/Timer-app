import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/db/db_service.dart';
import 'package:timer_app/models/session.dart';
import 'package:timer_app/riverpod/tags.dart';
import 'package:timer_app/utils/local_storage.dart';

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

final durationProvider = StateProvider<int>((ref) => 25);
final timerProvider = StateNotifierProvider<TimerNotifier, TimerState?>((ref) {
  return TimerNotifier(ref);
});

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier(this.ref)
      : super(TimerState(
            totalSeconds: ref.read(settingsProvider).duration * 60,
            isRunning: false,
            initialDuration: ref.read(settingsProvider).duration,
            percent: 100));

  final Ref ref;
  Timer? _timer;

  void startTimer() {
    if (!state.isRunning) {
      state = state.copyWith(isRunning: true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (state.totalSeconds > 0) {
          final percent =
              (state.totalSeconds / (state.initialDuration * 60)) * 100;
          state = state.copyWith(
              totalSeconds: state.totalSeconds - 1, percent: percent);
        } else {
          stopTimer();
        }
      });
    }
  }

  void setInitialDuration(int duration) {
    state = state.copyWith(
        totalSeconds: duration * 60,
        isRunning: false,
        initialDuration: duration,
        percent: 100);
  }

  void stopTimer() async {
    _timer?.cancel();

    final dbService = DbService();

    await dbService.saveSession(Session(
        uid: FirebaseAuth.instance.currentUser?.uid ?? "",
        duration: state.initialDuration,
        label: ref.read(currentTagProvider),
        isHealthy: state.totalSeconds == 0 ? true : false,
        timestamp: DateTime.now()));
    state = state.copyWith(
        totalSeconds: state.initialDuration * 60,
        isRunning: false,
        initialDuration: state.initialDuration,
        percent: 100);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
