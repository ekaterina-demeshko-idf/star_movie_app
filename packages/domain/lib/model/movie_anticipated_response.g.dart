// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_anticipated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieAnticipatedResponse _$MovieAnticipatedResponseFromJson(
        Map<String, dynamic> json) =>
    MovieAnticipatedResponse(
      listCount: json['list_count'] as num?,
      movie: json['movie'] == null ? null : Movie.fromJson(json['movie']),
    );

Map<String, dynamic> _$MovieAnticipatedResponseToJson(
        MovieAnticipatedResponse instance) =>
    <String, dynamic>{
      'list_count': instance.listCount,
      'movie': instance.movie?.toJson(),
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      title: json['title'] as String?,
      year: json['year'] as num?,
      ids: json['ids'] == null ? null : Ids.fromJson(json['ids']),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'ids': instance.ids,
    };

Ids _$IdsFromJson(Map<String, dynamic> json) => Ids(
      trakt: json['trakt'] as num?,
      slug: json['slug'] as String?,
      imdb: json['imdb'] as String?,
      tmdb: json['tmdb'] as num?,
    );

Map<String, dynamic> _$IdsToJson(Ids instance) => <String, dynamic>{
      'trakt': instance.trakt,
      'slug': instance.slug,
      'imdb': instance.imdb,
      'tmdb': instance.tmdb,
    };
