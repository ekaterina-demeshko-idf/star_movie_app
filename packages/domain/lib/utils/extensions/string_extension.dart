extension NullableStringExt on String? {
  String get orEmpty => this ?? '';
}

extension Capitalize on String {
  String get capitalize {
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}