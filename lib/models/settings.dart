class Settings {
  final String theme;
  final int duration;
  final int defaultTag;

  Settings(
      {required this.theme, required this.duration, required this.defaultTag});

  Settings copyWith({String? theme, int? duration, int? defaultTag}) {
    return Settings(
        theme: theme ?? this.theme,
        duration: duration ?? this.duration,
        defaultTag: defaultTag ?? this.defaultTag);
  }
}
