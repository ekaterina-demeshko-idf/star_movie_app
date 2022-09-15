import '../model/data_model.dart';

abstract class NetworkRepository {
  Future<GetMovieDataResponse> getMovieData({required String apiPath, int? itemCount});
}
