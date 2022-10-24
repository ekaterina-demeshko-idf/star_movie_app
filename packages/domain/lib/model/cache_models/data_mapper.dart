import 'package:domain/model/cache_models/cast_cache_model.dart';
import 'package:domain/model/cast/cast_with_images.dart';
import 'package:domain/model/movie/movie_response_model.dart';
import 'package:domain/model/cache_models/movie_cache_model.dart';

import '../cast/cast.dart';

abstract class DataMapper {
  factory DataMapper() => _DataMapper();

  Future<List<MovieCache>> mapMovieDataToCache(List<MovieResponse> response);

 // Future<List<CastCache>> mapCastDataToCache(List<Cast> response);
}

class _DataMapper implements DataMapper {
  @override
  Future<List<MovieCache>> mapMovieDataToCache(
      List<MovieResponse> response,) async {
    return response
        .map((e) =>
        MovieCache(
          e.movie.title,
          e.movie.ids?.imdb,
          e.movie.runtime,
          e.movie.rating?.toDouble(),
          e.movie.genres,
          e.movie.certification,
          e.movie.overview,
          e.movie.ids?.trakt,
          e.movie.ids?.tmdb,
        ))
        .toList();
  }

  // @override
  // Future<List<CastCache>> mapCastDataToCache(
  //     List<Cast> response,) async {
  //   return response
  //       .map((e) =>
  //       CastCache(
  //         e.character,
  //         e.person?.name,
  //         e.person?.ids?.trakt,
  //       ))
  //       .toList();
  // }
}
