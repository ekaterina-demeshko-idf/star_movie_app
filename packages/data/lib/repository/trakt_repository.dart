import 'package:data/utils/const.dart';
import 'package:domain/model/cast/cast.dart';
import 'package:domain/model/data_model.dart';
import 'package:domain/model/cast/cast_model.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import 'package:domain/repository/trakt_api_repository.dart';

class TraktAPIRepositoryImpl implements TraktAPIRepository {
  final ApiBaseService<ServicePayload> _movieApiService;

  TraktAPIRepositoryImpl(this._movieApiService);

  @override
  Future<GetMovieDataResponse> getMovieTrendingData(
      {int itemCount = 10}) async {
    final response = await _movieApiService.get(
      Config.apiTrendingPath,
      queryParameters: setItemLimit(itemCount),
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
      queryParameters: setItemLimit(itemCount),
    );

    return GetMovieDataResponse(
      headers: response.headers.map,
      body: (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  @override
  Future<CastModel> getCastData(int traktId) async {
    final response = await _movieApiService.get(
      '${Config.apiMoviesPath}$traktId/people',
    );
    return CastModel.fromJson(response.data);
  }

  Future<int?> getCastPersonTmdbId(int traktId) async {
    final response = await _movieApiService.get(
      '${Config.apiMoviesPath}$traktId/people',
    );
    return 7;
  }

  Map<String, Object> setItemLimit(int itemCount) {
    return {
      'extended': 'full',
      'page': 1,
      'limit': itemCount,
    };
  }
}
