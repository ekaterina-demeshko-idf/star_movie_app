import 'package:domain/model/movie_response.dart';
import '../../utils/funcs/capitalize.dart';
import '../../utils/funcs/convert_time.dart';

class MoviePresentation {
  final String title;
  final String image;
  final String runtime;
  final double rating;
  final String genre;
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
      movie.title ?? '',
      'http://img.omdbapi.com/?apikey=956febbc&i=${movie.ids?.imdb}',
      getTimeString(movie.runtime),
      (movie.rating ?? 0.0) / 2,
      capitalize(movie.genres?.first),
      movie.certification.toString(),
    );
  }
}
