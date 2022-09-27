extension NullableListExt<T> on List<T>? {
  List<T> get orEmpty => this ?? [];
}

extension CapitalizeListExt on List {
  List get capitalizeList {
    List newList = [];
    for (var s in this) {
      newList.add(s[0].toUpperCase() + s.substring(1).toLowerCase());
    }
    return newList;
  }

  String get cutToThree {
    if (this.length > 3) {
      this.length = 3;
      return this.capitalizeList.join(', ');
    } else {
      return this.capitalizeList.join(', ');
    }
  }
}
