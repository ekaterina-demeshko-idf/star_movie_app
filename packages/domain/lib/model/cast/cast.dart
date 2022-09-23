import 'package:json_annotation/json_annotation.dart';

part 'cast.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Cast {
  Cast({
    this.character,
    this.characters,
    this.person,
  });

  final String? character;
  final List<String>? characters;
  final Person? person;

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Person {
  String? name;
  Ids? ids;

  Person({
    this.name,
    this.ids,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ids {
  int? trakt;
  String? slug;
  String? imdb;
  int? tmdb;

  Ids({
    this.trakt,
    this.slug,
    this.imdb,
    this.tmdb,
  });

  factory Ids.fromJson(Map<String, dynamic> json) => _$IdsFromJson(json);

  Map<String, dynamic> toJson() => _$IdsToJson(this);
}
