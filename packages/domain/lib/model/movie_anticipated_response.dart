import 'package:json_annotation/json_annotation.dart';

part 'movie_anticipated_response.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MovieAnticipatedResponse {
  MovieAnticipatedResponse({
    this.listCount,
    this.movie,
  });

  MovieAnticipatedResponse.fromJson(dynamic json) {
    listCount = json['list_count'];
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
  }

  num? listCount;
  Movie? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['list_count'] = listCount;
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  Movie({
    this.title,
    this.year,
    this.ids,
  });

  Movie.fromJson(dynamic json) {
    title = json['title'];
    year = json['year'];
    ids = json['ids'] != null ? Ids.fromJson(json['ids']) : null;
  }

  String? title;
  num? year;
  Ids? ids;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['year'] = year;
    if (ids != null) {
      map['ids'] = ids?.toJson();
    }
    return map;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ids {
  Ids({
    this.trakt,
    this.slug,
    this.imdb,
    this.tmdb,
  });

  Ids.fromJson(dynamic json) {
    trakt = json['trakt'];
    slug = json['slug'];
    imdb = json['imdb'];
    tmdb = json['tmdb'];
  }

  num? trakt;
  String? slug;
  String? imdb;
  num? tmdb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trakt'] = trakt;
    map['slug'] = slug;
    map['imdb'] = imdb;
    map['tmdb'] = tmdb;
    return map;
  }
}
