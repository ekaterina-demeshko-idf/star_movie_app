import 'package:domain/enum/movie_type.dart';
import 'package:domain/model/cache_models/cast_cache_model.dart';
import 'package:domain/model/cache_models/movie_cache_model.dart';
import 'package:domain/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final SharedPreferences _preferencesProvider;
  final Database _db;

  LocalStorageRepositoryImpl(
    this._preferencesProvider,
    this._db,
  );

  @override
  Future<void> saveCredentials(
    String email,
    String password,
  ) async {
    await _preferencesProvider.setString(
      'email',
      email,
    );
    await _preferencesProvider.setString(
      'password',
      password,
    );
  }

  @override
  Future<void> saveDate(int date) async {
    await _preferencesProvider.setInt(
      'date',
      date,
    );
  }

  @override
  int? getDate() {
    return _preferencesProvider.getInt('date');
  }

  @override
  Future<void> saveMoviesToCache(
    List<MovieCache> remoteMovieList,
    MovieType movieType,
  ) async {
    if (remoteMovieList.isNotEmpty) {
      for (MovieCache movie in remoteMovieList) {
        _db.insert(
          'Movies',
          movie.toJson(
            movie,
            movieType,
          ),
        );
      }
    }
  }

  @override
  Future<void> clearMoviesTable(MovieType movieType) async {
    await _db.delete('Movies');
  }

  @override
  Future<void> deleteByIds(
    List<int> ids,
    MovieType movieType,
  ) async {
    if (ids.isNotEmpty) {
      for (int id in ids) {
        await _db.delete(
          'Movies',
          where: '"tmdb" = ?',
          whereArgs: [id],
        );
      }
    }
  }

  @override
  Future<List<MovieCache>> getMoviesFromCache(MovieType movieType) async {
    final List<Map<String, dynamic>> maps = await _db
        .query('Movies WHERE movieType = "${movieType.name}"');
    return List.generate(maps.length, (i) {
      return MovieCache(
        maps[i]['title'],
        maps[i]['imdb'],
        maps[i]['runtime'],
        maps[i]['rating'].toDouble(),
        maps[i]['genres'].split(','),
        maps[i]['certification'],
        maps[i]['overview'],
        maps[i]['trakt'],
        maps[i]['tmdb'],
      );
    });
  }

  @override
  Future<List<int>> getMoviesIdsFromCache(MovieType movieType) async {
    var tmdbFromDB = await _db.rawQuery('SELECT tmdb FROM Movies');
    return List<int>.from(tmdbFromDB.map((i) => i["tmdb"]).toList()).toList();
  }

  @override
  Future<void> setTimestampForMovieType(
    MovieType movieType,
    int timestamp,
  ) async {
    _db.insert(
      'requestHistory',
      {
        "timestamp": timestamp,
        "movieType": movieType.name,
      },
    );
  }

  @override
  Future<int?> getTimestampForMovieType(MovieType movieType) async {
    final int? timestamp = await _db
        .rawQuery(
          'SELECT timestamp FROM requestHistory WHERE movieType = "${movieType.name}"',
        )
        .then(
          (result) => result.map((e) => e['timestamp'] as int).firstOrNull,
        );
    return timestamp;
  }

  @override
  Future<void> saveCastToCache(List<CastCache> castCache) async {
    if (castCache.isNotEmpty) {
      for (CastCache cast in castCache) {
        _db.insert(
          'Cast',
          cast.toJson(cast),
        );
      }
    }
  }

  @override
  Future<List<CastCache>?> getCastFromCache(int? trakt) async {
    final List<CastCache>? cast = await _db
        .rawQuery(
          'SELECT * FROM Cast WHERE trakt = "$trakt"',
        )
        .then(
          (result) => result.map((e) => CastCache.fromResponse(e)).toList(),
        );
    return cast;
  }
}
