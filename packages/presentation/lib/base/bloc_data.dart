class BlocData<T>  {
  T? data;

  BlocData({
    this.data,
  });

  factory BlocData.init() => BlocData(
        data: null,
      );

  BlocData copy() => BlocData(
        data: data,
      );

  void updateParams(T data) {
    if (data != null) this.data = data;
  }
}
