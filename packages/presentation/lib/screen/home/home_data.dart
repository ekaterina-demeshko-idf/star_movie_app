import 'package:presentation/enum/current_tab.dart';

class HomeData {
  CurrentTab? currentTab;
  List<dynamic>? movieTrending;
  List<dynamic>? movieAnticipated;

  HomeData({this.movieTrending, this.movieAnticipated, this.currentTab});

  factory HomeData.init() => HomeData(movieTrending: [], movieAnticipated: [], currentTab: CurrentTab.trending);

  HomeData copy() => HomeData(
      movieTrending: movieTrending, movieAnticipated: movieAnticipated, currentTab: currentTab);

  HomeData copyWith({
    List<dynamic>? movieTrending,
    List<dynamic>? movieAnticipated,
    CurrentTab? currentTab,
  }) =>
      HomeData(
        movieTrending: movieTrending ?? this.movieTrending,
        movieAnticipated: movieAnticipated ?? this.movieAnticipated,
        currentTab: currentTab ?? this.currentTab,

      );
}
