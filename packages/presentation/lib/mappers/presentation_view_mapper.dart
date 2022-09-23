import 'package:domain/model/movie/movie_response_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/utils/extensions/int_extension.dart';
import 'package:domain/utils/extensions/list_extension.dart';
import 'package:domain/utils/getSecrets.dart';
import 'package:yaml/yaml.dart';
import '../models/movie_model.dart';

abstract class PresentationViewMapper {
  factory PresentationViewMapper() => _PresentationViewMapper();

  Future<List<MoviePresentation>> mapMovieDataToRequest(
      List<MovieResponse> response);
}

class _PresentationViewMapper implements PresentationViewMapper {
  late YamlMap secrets;

  _PresentationViewMapper() {
    getAsyncSecrets();
  }

  @override
  Future<List<MoviePresentation>> mapMovieDataToRequest(
    List<MovieResponse> response,
  ) async {
    String key = secrets["IMG_API_KEY"];
    return response
        .map((e) => MoviePresentation(
              e.movie.title.orEmpty,
              'http://img.omdbapi.com/?apikey=$key&i=${e.movie.ids?.imdb}',
              e.movie.runtime.convertTimeToString,
              (e.movie.rating ?? 0.0) / 2,
              e.movie.genres?.first.orEmpty.capitalize,
              e.movie.genres?.orEmpty.cutToThree,
              e.movie.certification.toString(),
              e.movie.overview.orEmpty,
              e.movie.ids?.trakt,
              e.movie.ids?.tmdb,
            ))
        .toList();
  }

  void getAsyncSecrets() async {
    secrets = await getSecrets();
  }
}
