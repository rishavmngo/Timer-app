class TimerSession {
  String? id;
  final DateTime createdAt;
  final int tagId;
  final int duration;
  final int elapsedTime;
  final bool healthy;
  TimerSession(
      {this.id,
      required this.createdAt,
      required this.tagId,
      required this.duration,
      required this.elapsedTime,
      required this.healthy});
}
