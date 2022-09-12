class BlocData<D> {
  bool isLoading;
  D? data;

  BlocData(
    this.isLoading,
    this.data,
  );

  factory BlocData.init() => BlocData<D>(
        false,
        null,
      );

  BlocData<D?> copy<D>() => BlocData<D?>(
        isLoading,
        data as D,
      );

  void updateParams(
    bool? isLoading,
    D data,
  ) {
    if (isLoading != null) this.isLoading = isLoading;
    if (data != null) this.data = data;
  }
}
