import '../model/cast/cast_model.dart';
import '../model/data_model.dart';

abstract class TraktAPIRepository {
  Future<GetMovieDataResponse> getMovieTrendingData({
    int itemCount = 10,
  });

  Future<GetMovieDataResponse> getMovieAnticipatedData({
    int itemCount = 10,
  });

  Future<CastModel> getCastData(int traktId);
}
