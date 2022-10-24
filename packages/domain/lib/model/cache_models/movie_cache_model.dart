import 'package:domain/enum/movie_type.dart';

const String tableMovies = 'movies';

class MovieFields {
  static final List<String> values = [
    movieType,
    title,
    imdb,
    runtime,
    rating,
    genres,
    certification,
    overview,
    trakt,
    tmdb,
  ];
  static const String movieType = 'movieType';
  static const String title = 'title';
  static const String imdb = 'imdb';
  static const String runtime = 'runtime';
  static const String rating = 'rating';
  static const String genres = 'genres';
  static const String certification = 'certification';
  static const String overview = 'overview';
  static const String trakt = 'trakt';
  static const String tmdb = 'tmdb';
}

class MovieCache {
  final String? title;
  final String? imdb;
  final int? runtime;
  final double? rating;
  final List<String>? genres;
  final dynamic certification;
  final String? overview;
  final int? trakt;
  final int? tmdb;

  MovieCache(
    this.title,
    this.imdb,
    this.runtime,
    this.rating,
    this.genres,
    this.certification,
    this.overview,
    this.trakt,
    this.tmdb,
  );

  static MovieCache fromResponse(Map<String, Object?> json) => MovieCache(
        json['title'] as String?,
        (json['ids'] as Map<String, dynamic>?)?['imdb']?.toString(),
        json['runtime'] as int?,
        (json['rating'] as num?)?.toDouble(),
        (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
        json['certification'],
        json['overview'] as String?,
        (json['ids'] as Map<String, dynamic>?)?['trakt'] as int?,
        (json['ids'] as Map<String, dynamic>?)?['tmdb'] as int?,
      );

  Map<String, dynamic> toJson(
    MovieCache movie,
    MovieType movieType,
  ) =>
      {
        MovieFields.movieType: movieType.name,
        MovieFields.title: movie.title,
        MovieFields.imdb: movie.imdb,
        MovieFields.runtime: movie.runtime,
        MovieFields.rating: movie.rating,
        MovieFields.genres: movie.genres.toString(),
        MovieFields.certification: movie.certification.toString(),
        MovieFields.overview: movie.overview,
        MovieFields.trakt: movie.trakt,
        MovieFields.tmdb: movie.tmdb,
      };
}
