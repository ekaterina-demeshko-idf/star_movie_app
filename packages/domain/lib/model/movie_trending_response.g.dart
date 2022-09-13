// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_trending_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieTrendingResponse _$MovieTrendingResponseFromJson(
        Map<String, dynamic> json) =>
    MovieTrendingResponse(
      json['watchers'] as int?,
      Movie.fromJson(json['movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieTrendingResponseToJson(
        MovieTrendingResponse instance) =>
    <String, dynamic>{
      'watchers': instance.watchers,
      'movie': instance.movie.toJson(),
    };
