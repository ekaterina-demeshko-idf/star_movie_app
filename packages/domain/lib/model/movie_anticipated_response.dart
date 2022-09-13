import 'package:json_annotation/json_annotation.dart';

import 'movie_response.dart';

part 'movie_anticipated_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MovieAnticipatedResponse {
  final num? listCount;
  final Movie movie;

  MovieAnticipatedResponse(
    this.listCount,
    this.movie,
  );

  factory MovieAnticipatedResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieAnticipatedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieAnticipatedResponseToJson(this);
}
