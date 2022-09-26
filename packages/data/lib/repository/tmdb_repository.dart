import 'package:domain/repository/tmdb_api_repository.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import 'package:domain/model/cast/tmdb_image.dart';

import '../utils/apiPath.dart';

class TmdbAPIRepositoryImpl implements TmdbAPIRepository {
  final ApiBaseService<ServicePayload> _tmdbService;

  TmdbAPIRepositoryImpl(this._tmdbService);

  @override
  Future<TmdbImage> getCastImageFilePath(int tmdbId, String apiKey) async {
    final response = await _tmdbService.get(
      ApiPath.getCastImageFilePath(tmdbId),
      queryParameters: setApiKey(apiKey),
    );
    return TmdbImage.fromJson(response.data);
  }

  Map<String, Object> setApiKey(String apiKey) {
    return {
      'api_key': apiKey,
    };
  }
}
