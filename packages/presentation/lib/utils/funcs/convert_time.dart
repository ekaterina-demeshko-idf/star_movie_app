String getTimeString(int? value) {
  final int hour = (value ?? 0) ~/ 60;
  final int minutes = (value ?? 0) % 60;
  return '${hour.toString()}h ${minutes.toString().padLeft(2, "0")}m';
}