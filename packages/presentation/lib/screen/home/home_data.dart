class HomeData {
  int selectedIndex;
  List<dynamic>? movieTrending;
  List<dynamic>? movieAnticipated;

  HomeData(this.selectedIndex, this.movieTrending, this.movieAnticipated);

  factory HomeData.init() => HomeData(0, [], []);

  HomeData copy() => HomeData(selectedIndex, movieTrending, movieAnticipated);
}
