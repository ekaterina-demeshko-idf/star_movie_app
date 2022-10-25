import 'dart:async';
import 'package:sqflite/sqflite.dart';

class MovieDatabase {
  static const name = 'movies.db';
  static const version = 3;


  void _renameTableMoviesV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS MoviesAnticipated');
    batch.execute('''ALTER TABLE MoviesTrending
        RENAME TO Movies''');
    batch.execute('''ALTER TABLE Movies
    ADD movieType TEXT DEFAULT trending''');
  }

  void _renameTableCastV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS anticipatedCast');
    batch.execute('''ALTER TABLE trendingCast
        RENAME TO Cast''');
  }

  void upgradeDB(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    if (oldVersion == 2) {
      _renameTableCastV2(batch);
      _renameTableMoviesV2(batch);
    }
    await batch.commit();
  }

  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Movies (
      movieType TEXT,
      title TEXT,
      imdb TEXT,
      runtime INTEGER,
      rating INTEGER,
      genres TEXT,
      certification TEXT,
      overview TEXT,
      tmdb INTEGER,
      trakt INTEGER PRIMARY KEY
      )''');

    await db.execute('''
      CREATE TABLE Cast (
      character TEXT,
      name TEXT,
      image TEXT,
      trakt INTEGER,
      FOREIGN KEY (trakt) REFERENCES Movies(trakt) ON DELETE CASCADE
      )''');

    await db.execute('''
      CREATE TABLE requestHistory (
      movieType TEXT,
      timestamp INTEGER
      )''');
  }
}
