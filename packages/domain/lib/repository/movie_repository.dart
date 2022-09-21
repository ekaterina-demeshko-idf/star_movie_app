import '../model/data_model.dart';

abstract class NetworkRepository {
  Future<GetMovieDataResponse> getMovieTrendingData({
    int itemCount = 10,
  });

  Future<GetMovieDataResponse> getMovieAnticipatedData({
    int itemCount = 10,
  });
}
