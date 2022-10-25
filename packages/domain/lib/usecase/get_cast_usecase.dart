import 'package:domain/model/cast/cast_with_images.dart';
import 'package:domain/model/cast/cast_model.dart';
import 'package:domain/utils/apiPath.dart';
import '../model/cast/tmdb_image.dart';
import '../model/cast/cast.dart';
import '../repository/local_storage_repository.dart';
import '../repository/tmdb_api_repository.dart';
import '../repository/trakt_api_repository.dart';
import 'usecase.dart';

class GetCastUseCase implements UseCaseParams<int?, Future<List<CastAndImages>?>> {
  final TraktAPIRepository _traktAPIRepository;
  final TmdbAPIRepository _tmdbAPIRepository;
  final LocalStorageRepository _localStorageRepository;

  GetCastUseCase(
    this._traktAPIRepository,
    this._tmdbAPIRepository,
    this._localStorageRepository,
  );

  @override
  Future<List<CastAndImages>?> call(int? traktId) async {
    final List<CastAndImages>? cacheList =
        await _localStorageRepository.getCastFromCache(traktId);
    if (cacheList != null && cacheList.isEmpty) {
      final CastModel castResponse =
          await _traktAPIRepository.getCastData(traktId ?? 0);
      final List<Cast>? cast = castResponse.cast;
      final List<Future<CastAndImages>>? castAndImagesFutureList =
          cast?.map((e) async {
        final TmdbImage filePath = await _tmdbAPIRepository
            .getCastImageFilePath(e.person?.ids?.tmdb ?? 0);
        final String? url = filePath.profiles?.isNotEmpty == true
            ? ApiPath.getCastImagePath(
                filePath.profiles![0].filePath?.toString(),
              )
            : null;
        return CastAndImages(
          e.character,
          e.person?.name,
          url,
          traktId,
        );
      }).toList();

      final List<CastAndImages> castAndImagesList =
          await Future.wait(castAndImagesFutureList ?? []);
      await _localStorageRepository.saveCastToCache(castAndImagesList);
      return castAndImagesList;
    } else {
      return cacheList;
    }
  }
}
