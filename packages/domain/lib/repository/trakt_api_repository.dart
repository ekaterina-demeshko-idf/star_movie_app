import '../model/data_model.dart';

abstract class TraktAPIRepository {
  Future<GetMovieDataResponse> getMovieTrendingData({
    int itemCount = 10,
  });

  Future<GetMovieDataResponse> getMovieAnticipatedData({
    int itemCount = 10,
  });

  Future<dynamic> getCastData(int traktId);
}
