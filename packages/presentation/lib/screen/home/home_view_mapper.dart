import 'package:domain/model/movie_anticipated_response.dart';
import 'package:domain/model/movie_trending_response.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/utils/extensions/int_extension.dart';
import 'movie_model.dart';

abstract class HomeViewMapper {
  factory HomeViewMapper() => _HomeViewMapper();

  List<MoviePresentation> mapTrendingDataToRequest(
      List<MovieTrendingResponse> response);

  List<MoviePresentation> mapAnticipatedDataToRequest(
      List<MovieAnticipatedResponse> response);
}

class _HomeViewMapper implements HomeViewMapper {
  @override
  List<MoviePresentation> mapTrendingDataToRequest(
    List<MovieTrendingResponse> response,
  ) =>
      response
          .map((e) => MoviePresentation(
                e.movie.title.orEmpty,
                'http://img.omdbapi.com/?apikey=956febbc&i=${e.movie.ids?.imdb}',
                e.movie.runtime.convertTimeToString,
                (e.movie.rating ?? 0.0) / 2,
                e.movie.genres?.first.orEmpty.capitalize,
                e.movie.certification.toString(),
              ))
          .toList();

  @override
  List<MoviePresentation> mapAnticipatedDataToRequest(
    List<MovieAnticipatedResponse> response,
  ) =>
      response
          .map((e) => MoviePresentation(
                e.movie.title.orEmpty,
                'http://img.omdbapi.com/?apikey=956febbc&i=${e.movie.ids?.imdb}',
                e.movie.runtime.convertTimeToString,
                (e.movie.rating ?? 0.0) / 2,
                e.movie.genres?.first.orEmpty.capitalize,
                e.movie.certification.toString(),
              ))
          .toList();
}
