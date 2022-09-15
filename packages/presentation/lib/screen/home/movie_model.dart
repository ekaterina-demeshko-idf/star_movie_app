import 'package:domain/model/movie_response.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/utils/extensions/int_extension.dart';

class MoviePresentation {
  final String title;
  final String image;
  final String runtime;
  final double rating;
  final String? genre;
  final String? certification;

  MoviePresentation(
    this.title,
    this.image,
    this.runtime,
    this.rating,
    this.genre,
    this.certification,
  );

  factory MoviePresentation.fromMovie(Movie movie) {
    return MoviePresentation(
      movie.title.orEmpty,
      'http://img.omdbapi.com/?apikey=956febbc&i=${movie.ids?.imdb}',
      movie.runtime.convertTimeToString,
      (movie.rating ?? 0.0) / 2,
      movie.genres?.first.orEmpty.capitalize,
      movie.certification.toString(),
    );
  }
}
