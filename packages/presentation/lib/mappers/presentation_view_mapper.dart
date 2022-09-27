import 'package:domain/model/movie/movie_response_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/utils/extensions/int_extension.dart';
import 'package:domain/utils/extensions/list_extension.dart';
import 'package:domain/utils/getSecrets.dart';
import 'package:yaml/yaml.dart';
import '../models/movie_model.dart';

abstract class HomeViewMapper {
  factory HomeViewMapper() => _HomeViewMapper();

  Future<List<MoviePresentation>> mapMovieDataToRequest(
      List<MovieResponse> response);
}

class _HomeViewMapper implements HomeViewMapper {
  late YamlMap secrets;

  _HomeViewMapper() {
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
