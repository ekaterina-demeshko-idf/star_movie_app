import 'package:domain/enum/movie_type.dart';
import 'package:domain/model/cast/cast_with_images.dart';
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
  Future<void> saveMoviesToCache(
    List<MovieCache> remoteMovieList,
    MovieType movieType,
  ) async {
    Batch batch = _db.batch();
    if (remoteMovieList.isNotEmpty) {
      for (MovieCache movie in remoteMovieList) {
        batch.insert(
          'Movies',
          movie.toJson(
            movie,
            movieType,
          ),
        );
      }
      await batch.commit();
    }
  }

  @override
  Future<void> deleteByIds(
    List ids,
    MovieType movieType,
  ) async {
    Batch batch = _db.batch();
    List<dynamic> args = [];
    if (ids.isNotEmpty) {
      args.addAll(ids);
      args.add(movieType.name);
      batch.delete(
        'Movies',
        where: '''"trakt" in (${List.filled(ids.length - 1, '?').join(',')}) 
        and "movieType" = ?''',
        whereArgs: args,
      );
      await batch.commit();
    }
  }

  @override
  Future<List<MovieCache>> getMoviesFromCache(MovieType movieType) async {
    final List<Map<String, dynamic>> maps =
        await _db.query('Movies WHERE movieType = "${movieType.name}"');
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
    var traktFromDB = await _db.rawQuery('SELECT trakt FROM Movies');
    return List<int>.from(traktFromDB.map((i) => i["trakt"]).toList()).toList();
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
  Future<void> saveCastToCache(List<CastAndImages> castCache) async {
    Batch batch = _db.batch();
    if (castCache.isNotEmpty) {
      for (CastAndImages cast in castCache) {
        batch.insert(
          'Cast',
          cast.toJson(cast),
        );
      }
      await batch.commit();
    }
  }

  @override
  Future<List<CastAndImages>?> getCastFromCache(int? trakt) async {
    final List<CastAndImages>? cast = await _db
        .rawQuery(
          'SELECT * FROM Cast WHERE trakt = $trakt',
        )
        .then(
          (result) => result.map((e) => CastAndImages.fromResponse(e)).toList(),
        );
    return cast;
  }
}
