import 'package:data/utils/const.dart';
import 'package:domain/model/data_model.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import 'package:domain/repository/movie_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final ApiBaseService<ServicePayload> _movieApiService;

  NetworkRepositoryImpl(this._movieApiService);

  @override
  Future<GetMovieDataResponse> getMovieTrendingData(
      {int itemCount = 10}) async {
    final response = await _movieApiService.get(
      Config.apiTrendingPath,
      setQueryParams(itemCount),
    );

    return GetMovieDataResponse(
      headers: response.headers.map,
      body: (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  @override
  Future<GetMovieDataResponse> getMovieAnticipatedData(
      {int itemCount = 10}) async {
    final response = await _movieApiService.get(
      Config.apiAnticipatedPath,
      setQueryParams(itemCount),
    );

    return GetMovieDataResponse(
      headers: response.headers.map,
      body: (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  Map<String, Object> setQueryParams(int itemCount) {
    return {
      'extended': 'full',
      'page': 1,
      'limit': itemCount,
    };
  }
}
