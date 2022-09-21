extension ConvertTime on int? {
  String get convertTimeToString {
    final int hour = (this ?? 0) ~/ 60;
    final int minutes = (this ?? 0) % 60;
    return '${hour.toString()}h ${minutes.toString().padLeft(2, "0")}m';
  }
}