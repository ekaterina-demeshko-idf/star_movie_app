import 'package:domain/repository/tmdb_api_repository.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import '../utils/const.dart';
import 'package:domain/model/cast/tmdb_image.dart';

class TmdbAPIRepositoryImpl implements TmdbAPIRepository {
  final ApiBaseService<ServicePayload> _tmdbService;

  TmdbAPIRepositoryImpl(this._tmdbService);

  @override
  Future<TmdbImage> getCastImageFilePath(int tmdbId) async {
    final response = await _tmdbService.get(
      '${Config.tmdbPersonPath}/$tmdbId/images',
      queryParameters: {"api_key": "1dfbe05461f443007f2613fca125cdd8"},
    );
    return TmdbImage.fromJson(response.data);
    // return TmdbImage(
    //   profiles: response.data['profiles'].map((e) => Profiles.fromJson(e)).toList(),
    // );
  }
}
