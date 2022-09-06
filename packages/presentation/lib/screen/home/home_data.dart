class HomeData {
  int selectedIndex;

  HomeData(this.selectedIndex);

  factory HomeData.init() => HomeData(1);

  HomeData copy() => HomeData(selectedIndex);
}
