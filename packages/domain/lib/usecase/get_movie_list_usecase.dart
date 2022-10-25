import 'package:domain/model/data_model.dart';
import 'package:domain/model/cache_models/movie_cache_model.dart';
import '../enum/movie_type.dart';
import '../repository/local_storage_repository.dart';
import '../utils/const.dart';
import '../repository/trakt_api_repository.dart';
import 'usecase.dart';

class GetMovieListUseCase
    implements UseCaseParams<MovieType, Future<List<MovieCache>>> {
  final TraktAPIRepository _repository;
  final LocalStorageRepository _localStorageRepository;

  GetMovieListUseCase(
    this._repository,
    this._localStorageRepository,
  );

  @override
  Future<List<MovieCache>> call(MovieType currentMovieType) async {
    final List<MovieCache> jsonMovies = [];
    final List<MovieCache> jsonMoviesFromCache = [];
    final List<int> movieCacheIds = [];
    if (await _isTimestampNewDay(
      DateTime.now(),
      currentMovieType,
    )) {
      final GetMovieDataResponse response =
          currentMovieType == MovieType.anticipated
              ? await _repository.getMovieAnticipatedData()
              : await _repository.getMovieTrendingData();
      final pageCount = int.parse(response.headers[Config.pageCount][0]);
      final itemCount = pageCount >= 5
          ? 50
          : int.parse(response.headers[Config.itemCount][0]);
      await _getMoviesFromTrakt(
        itemCount,
        jsonMovies,
        currentMovieType,
      );
      movieCacheIds.addAll(await _localStorageRepository
          .getMoviesIdsFromCache(currentMovieType));
      final List<int> idsToDeleteFromDB = movieCacheIds
          .where((e1) => jsonMovies.where((e) => e.trakt == e1).isEmpty)
          .toList();
      await _localStorageRepository.deleteByIds(
          idsToDeleteFromDB, currentMovieType);
      final List<MovieCache> moviesToAddToDB = jsonMovies
          .where(
              (movie) => movieCacheIds.where((id) => movie.trakt == id).isEmpty)
          .toList();
      await _localStorageRepository.saveMoviesToCache(
          moviesToAddToDB, currentMovieType);
      return jsonMovies;
    } else {
      jsonMoviesFromCache.addAll(
          await _localStorageRepository.getMoviesFromCache(currentMovieType));
      return jsonMoviesFromCache;
    }
  }

  Future<List<MovieCache>> _getMoviesFromTrakt(
    int itemCount,
    List<MovieCache> jsonMovies,
    MovieType movieType,
  ) async {
    final response = (movieType == MovieType.anticipated)
        ? await _repository.getMovieAnticipatedData(itemCount: itemCount)
        : await _repository.getMovieTrendingData(itemCount: itemCount);
    jsonMovies
        .addAll(response.body.map((e) => MovieCache.fromResponse(e['movie'])));
    return jsonMovies;
  }

  Future<bool> _isTimestampNewDay(
    DateTime now,
    MovieType movieType,
  ) async {
    final today = DateTime(now.year, now.month, now.day);
    final int todayMilliseconds = today.millisecondsSinceEpoch;
    final int? timestampFromCache =
        await _localStorageRepository.getTimestampForMovieType(movieType);
    if (timestampFromCache == null) {
      _localStorageRepository.setTimestampForMovieType(
        movieType,
        now.millisecondsSinceEpoch,
      );
      return true;
    } else if (timestampFromCache >= todayMilliseconds) {
      return false;
    } else if (timestampFromCache < todayMilliseconds) {
      _localStorageRepository.setTimestampForMovieType(
        movieType,
        now.millisecondsSinceEpoch,
      );
      return true;
    } else {
      return true;
    }
  }
}
