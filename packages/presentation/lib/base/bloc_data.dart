class BlocData {
  dynamic data;

  BlocData(
    this.data,
  );

  factory BlocData.init() => BlocData(
        null,
      );

  BlocData copy() => BlocData(
        data,
      );

  void updateParams(dynamic data) {
    if (data != null) this.data = data;
  }
}
