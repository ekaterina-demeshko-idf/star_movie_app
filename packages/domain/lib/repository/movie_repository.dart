import '../model/data_model.dart';

abstract class NetworkRepository {
  Future<GetDataResponse> getMovieData({required String apiPath, int? itemCount});
}
