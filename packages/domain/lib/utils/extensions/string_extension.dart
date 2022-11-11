extension NullableStringExt on String? {
  String get orEmpty => this ?? '';
}

extension Capitalize on String {
  String get capitalize {
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}

extension Insert on String {
  String addCharAtPosition(
    String char,
    int position,
  ) {
    if (this.length < position) {
      return this;
    }
    var before = this.substring(0, position);
    var after = this.substring(position, this.length);
    return before + char + after;
  }
}
