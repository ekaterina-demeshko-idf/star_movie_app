import 'package:data/utils/const.dart';
import 'package:domain/model/data_model.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import 'package:domain/repository/movie_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final ApiBaseService<ServicePayload> _movieApiService;

  NetworkRepositoryImpl(this._movieApiService);

  @override
  Future<GetMovieDataResponse> getMovieTrendingData({
    required Map<String, dynamic> queryParameters,
  }) async {
    final response = await _movieApiService.get(
      Config.apiTrendingPath,
      queryParameters,
    );

    return GetMovieDataResponse(
      headers: response.headers.map,
      body: (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  @override
  Future<GetMovieDataResponse> getMovieAnticipatedData({
    required Map<String, dynamic> queryParameters,
  }) async {
    final response = await _movieApiService.get(
      Config.apiAnticipatedPath,
      queryParameters,
    );

    return GetMovieDataResponse(
      headers: response.headers.map,
      body: (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }
}
