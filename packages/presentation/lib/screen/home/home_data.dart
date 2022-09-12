import 'package:domain/model/movie_trending_response.dart';

class HomeData {
  int selectedIndex;
  List<dynamic>? movieResponse;
  List<dynamic>? movieAnticipated;

  HomeData(this.selectedIndex, this.movieResponse, this.movieAnticipated);

  factory HomeData.init() => HomeData(0, [], []);

  HomeData copy() => HomeData(selectedIndex, movieResponse, movieAnticipated);
}
