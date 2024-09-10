String clampText(String text, int length) {
  if (text.length > length) {
    return "${text.substring(0, length - 1)}...";
  }
  return text;
}
