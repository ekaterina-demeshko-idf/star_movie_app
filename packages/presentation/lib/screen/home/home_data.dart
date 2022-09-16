class HomeData {
  List<dynamic>? movieTrending;
  List<dynamic>? movieAnticipated;

  HomeData(this.movieTrending, this.movieAnticipated);

  factory HomeData.init() => HomeData([], []);

  HomeData copy() => HomeData(movieTrending, movieAnticipated);
}
