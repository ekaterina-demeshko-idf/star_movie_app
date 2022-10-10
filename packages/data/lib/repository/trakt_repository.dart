import 'package:data/utils/const.dart';
import 'package:domain/model/data_model.dart';
import 'package:domain/model/cast/cast_model.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import 'package:domain/repository/trakt_api_repository.dart';

import '../utils/apiPath.dart';

class TraktAPIRepositoryImpl implements TraktAPIRepository {
  final ApiBaseService<ServicePayload> _movieApiService;

  TraktAPIRepositoryImpl(this._movieApiService);

  @override
  Future<GetMovieDataResponse> getMovieTrendingData(
      {int itemCount = 10}) async {
    final response = await _movieApiService.get(
      ApiPath.apiTrendingPath,
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
      ApiPath.apiAnticipatedPath,
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
      ApiPath.getCastDataPath(traktId),
    );
    return CastModel.fromJson(response.data);
  }

  Map<String, Object> setItemLimit(int itemCount) {
    return {
      'extended': 'full',
      'page': 1,
      'limit': itemCount,
    };
  }
}
