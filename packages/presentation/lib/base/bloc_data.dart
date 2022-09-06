class BlocData<D>  {
  D? data;

  BlocData({
    this.data,
  });

  factory BlocData.init() => BlocData<D>(
        data: null,
      );

  BlocData<D?> copy<D>() => BlocData<D?>(
        data: data as D,
      );

  void updateParams(D data) {
    if (data != null) this.data = data;
  }
}
