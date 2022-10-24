import 'package:domain/enum/movie_type.dart';

import '../model/cache_models/movie_cache_model.dart';

abstract class LocalStorageRepository {
  Future<void> saveCredentials(String email, String password);

  Future<void> saveDate(int date);

  int? getDate();

  Future<void> saveMoviesToCache(
    List<MovieCache> remoteMovieList,
    MovieType movieType,
  );

  Future<List<int>> getMoviesIdsFromCache(MovieType movieType);

  Future<void> clearMoviesTable(MovieType movieType);

  Future<void> deleteByIds(
    List<int> ids,
    MovieType movieType,
  );

  Future<void> setTimestampForMovieType(
    MovieType movieType,
    int timestamp,
  );

  Future<int?> getTimestampForMovieType(MovieType movieType);

  Future<List<MovieCache>> getMoviesFromCache(MovieType movieType);
}
