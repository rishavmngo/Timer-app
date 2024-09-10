class Session {
  String? id;
  final String uid;
  final DateTime timestamp;
  final String label;
  final int duration;
  final bool isHealthy;
  Session(
      {this.id,
      required this.uid,
      required this.timestamp,
      required this.label,
      required this.duration,
      required this.isHealthy});
}
