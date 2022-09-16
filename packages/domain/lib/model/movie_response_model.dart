import 'package:json_annotation/json_annotation.dart';

import 'movie_response.dart';

part 'movie_response_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MovieResponse {
  final int? watchers;
  final int? listCount;
  final Movie movie;

  MovieResponse(
    this.watchers,
    this.listCount,
    this.movie,
  );

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
