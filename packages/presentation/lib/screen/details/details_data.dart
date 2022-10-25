import 'package:domain/model/cast/cast_with_images.dart';
import '../../models/movie_model.dart';

class DetailsData {
  final MoviePresentation? movie;
  final List<CastAndImages>? cast;

  DetailsData({this.movie, this.cast});

  DetailsData copyWith({
    MoviePresentation? movie,
    List<CastAndImages>? cast,
  }) =>
      DetailsData(
        movie: movie ?? this.movie,
        cast: cast ?? this.cast,
      );
}
