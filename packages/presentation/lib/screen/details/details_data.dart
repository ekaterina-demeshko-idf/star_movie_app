import 'package:domain/model/cache_models/cast_cache_model.dart';
import 'package:domain/model/cast/cast_with_images.dart';
import '../../models/movie_model.dart';

class DetailsData {
  final MoviePresentation? movie;
  final List<CastCache>? cast;

  DetailsData({this.movie, this.cast});

  DetailsData copyWith({
    MoviePresentation? movie,
    List<CastCache>? cast,
  }) =>
      DetailsData(
        movie: movie ?? this.movie,
        cast: cast ?? this.cast,
      );
}
