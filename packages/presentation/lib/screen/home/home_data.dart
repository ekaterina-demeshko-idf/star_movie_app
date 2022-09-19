class HomeData {
  List<dynamic>? movieTrending;
  List<dynamic>? movieAnticipated;

  HomeData({this.movieTrending, this.movieAnticipated});

  factory HomeData.init() => HomeData(movieTrending: [], movieAnticipated: []);

  HomeData copy() => HomeData(
      movieTrending: movieTrending, movieAnticipated: movieAnticipated);

  HomeData copyWith({
    List<dynamic>? movieTrending,
    List<dynamic>? movieAnticipated,
  }) =>
      HomeData(
        movieTrending: movieTrending ?? this.movieTrending,
        movieAnticipated: movieAnticipated ?? this.movieAnticipated,
      );
}
