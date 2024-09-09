class Settings {
  final String theme;
  final int duration;

  Settings({required this.theme, required this.duration});

  Settings copyWith({String? theme, int? duration}) {
    return Settings(
        theme: theme ?? this.theme, duration: duration ?? this.duration);
  }
}
