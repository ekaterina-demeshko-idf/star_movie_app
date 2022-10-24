import 'package:domain/model/cache_models/cast_cache_model.dart';
import 'package:domain/model/cache_models/data_mapper.dart';
import 'package:domain/model/cast/cast_model.dart';
import 'package:domain/utils/apiPath.dart';
import '../model/cast/tmdb_image.dart';
import '../model/cast/cast.dart';
import '../model/cast/cast_with_images.dart';
import '../repository/local_storage_repository.dart';
import '../repository/tmdb_api_repository.dart';
import '../repository/trakt_api_repository.dart';
import 'usecase.dart';

class GetCastUseCase
    implements UseCaseParams<int?, Future<List<CastCache>?>> {
  final TraktAPIRepository _traktAPIRepository;
  final TmdbAPIRepository _tmdbAPIRepository;
  final LocalStorageRepository _localStorageRepository;

  GetCastUseCase(
    this._traktAPIRepository,
    this._tmdbAPIRepository,
      this._localStorageRepository,
  );
  @override
  Future<List<CastCache>?> call(int? traktId) async {
    //if id already in db get from db, else get from traktAPI and save to cache

    final List<CastCache>? cacheList = await _localStorageRepository.getCastFromCache(traktId);
    if (cacheList != null && cacheList.isEmpty) {
      final CastModel castResponse =
      await _traktAPIRepository.getCastData(traktId ?? 0);
      final List<Cast>? cast = castResponse.cast;

      final List<Future<CastCache>>? castAndImagesFutureList =
      cast?.map((e) async {
        final TmdbImage filePath = await _tmdbAPIRepository
            .getCastImageFilePath(e.person?.ids?.tmdb ?? 0);

        final String? url = filePath.profiles?.isNotEmpty == true
            ? ApiPath.getCastImagePath(filePath.profiles![0].filePath?.toString())
            : null;

        return CastCache(
          e.character,
          e.person?.name,
          url,
          e.person?.ids?.trakt,
        );
      }).toList();

      final List<CastCache> castAndImagesList =
      await Future.wait(castAndImagesFutureList ?? []);
      // save to cache
      await _localStorageRepository.saveCastToCache(castAndImagesList);
      return castAndImagesList;
    } else {
      return cacheList;
    }

  }
  // @override
  // Future<List<CastAndImages>?> call(int? traktId) async {
  //   //if id already in db get from db, else get from traktAPI and save to cache
  //
  //   await _localStorageRepository.getCastFromCache(traktId);
  //   if (_getCastFromCache() == null) {
  //     final CastModel castResponse =
  //         await _traktAPIRepository.getCastData(traktId ?? 0);
  //     final List<Cast>? cast = castResponse.cast;
  //
  //     final List<Future<CastAndImages>>? castAndImagesFutureList =
  //     cast?.map((e) async {
  //       final TmdbImage filePath = await _tmdbAPIRepository
  //           .getCastImageFilePath(e.person?.ids?.tmdb ?? 0);
  //
  //       final String? url = filePath.profiles?.isNotEmpty == true
  //           ? ApiPath.getCastImagePath(filePath.profiles![0].filePath?.toString())
  //           : null;
  //
  //       return CastAndImages(
  //         e.person?.name,
  //         url,
  //         e.character,
  //       );
  //     }).toList();
  //
  //     final List<CastAndImages> castAndImagesList =
  //     await Future.wait(castAndImagesFutureList ?? []);
  //     // save to cache
  //     return castAndImagesList;
  //   }
  //
  // }

  Future<CastModel?> _getCastFromCache() async {}
}
