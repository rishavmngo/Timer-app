String FormatSecondsToMMSS(int seconds) {
  final int minutes = seconds ~/ 60; // Integer division to get minutes
  final int remainingSeconds =
      seconds % 60; // Remainder to get remaining seconds

  // Formatting the string to ensure two digits for both minutes and seconds
  final String formattedMinutes = minutes.toString().padLeft(2, '0');
  final String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');

  return '$formattedMinutes:$formattedSeconds';
}
