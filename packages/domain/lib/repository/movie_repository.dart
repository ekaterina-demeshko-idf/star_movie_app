import '../model/data_model.dart';

abstract class NetworkRepository {
  Future<GetMovieDataResponse> getMovieTrendingData({
    required Map<String, Object> queryParameters,
  });

  Future<GetMovieDataResponse> getMovieAnticipatedData({
    required Map<String, Object> queryParameters,
  });
}
