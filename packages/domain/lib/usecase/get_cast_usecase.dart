import 'package:domain/model/cast/cast_model.dart';
import '../model/cast/tmdb_image.dart';
import '../model/cast/cast.dart';
import '../model/cast/cast_with_images.dart';
import '../repository/tmdb_api_repository.dart';
import '../repository/trakt_api_repository.dart';
import 'usecase.dart';

class GetCastUseCase
    implements UseCaseParams<int?, Future<List<CastAndImages>?>> {
  final TraktAPIRepository _traktAPIRepository;
  final TmdbAPIRepository _tmdbAPIRepository;

  GetCastUseCase(
    this._traktAPIRepository,
    this._tmdbAPIRepository,
  );

  @override
  Future<List<CastAndImages>?> call(int? traktId) async {
    final CastModel castResponse =
        await _traktAPIRepository.getCastData(traktId ?? 0);

    final List<Cast>? cast = castResponse.cast;

    final List<Future<CastAndImages>>? castAndImagesFutureList =
        cast?.map((e) async {
      final TmdbImage filePath = await _tmdbAPIRepository
          .getCastImageFilePath(e.person?.ids?.tmdb ?? 0);

      final String? url = filePath.profiles?.isNotEmpty == true
          ? 'https://image.tmdb.org/t/p/w185${filePath.profiles![0].filePath?.toString()}'
          : null;

      return CastAndImages(
        e.person?.name,
        url,
        e.character,
      );
    }).toList();

    final List<CastAndImages> castAndImagesList =
        await Future.wait(castAndImagesFutureList ?? []);

    return castAndImagesList;
  }
}
