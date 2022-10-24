import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MovieDatabase {
  static const name = 'movies.db';
  static const version = 1;
  static const anticipatedDB = 'MoviesAnticipated';
  static const trendingDB = 'MoviesTrending';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(name);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future<void> createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $anticipatedDB (
      title TEXT,
      imdb TEXT,
      runtime INTEGER,
      rating INTEGER,
      genres TEXT,
      certification TEXT,
      overview TEXT,
      trakt INTEGER,
      tmdb INTEGER
      )''');

    await db.execute('''
      CREATE TABLE $trendingDB (
      title TEXT,
      imdb TEXT,
      runtime INTEGER,
      rating INTEGER,
      genres TEXT,
      certification TEXT,
      overview TEXT,
      trakt INTEGER,
      tmdb INTEGER
      )''');

    await db.execute('''
      CREATE TABLE anticipatedCast (
      character TEXT,
      name TEXT,
      tmdbAnticipated INTEGER,
      FOREIGN KEY (tmdbAnticipated) REFERENCES $anticipatedDB(tmdb)
      )''');

    await db.execute('''
      CREATE TABLE trendingCast (
      character TEXT,
      name TEXT,
      tmdbTrending INTEGER,
      FOREIGN KEY (tmdbTrending) REFERENCES $trendingDB(tmdb)
      )''');

    await db.execute('''
      CREATE TABLE requestHistory (
      movieType TEXT,
      timestamp INTEGER
      )''');
  }
}
