import 'package:json_annotation/json_annotation.dart';

part 'tmdb_image.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TmdbImage {
  int? id;
  List<Profiles>? profiles;

  TmdbImage({
    this.id,
    this.profiles,
  });

  factory TmdbImage.fromJson(Map<String, dynamic> json) =>
      _$TmdbImageFromJson(json);

  Map<String, dynamic> toJson() => _$TmdbImageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Profiles {
  String? filePath;

  Profiles({
    this.filePath,
  });

  factory Profiles.fromJson(Map<String, dynamic> json) =>
      _$ProfilesFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilesToJson(this);
}
