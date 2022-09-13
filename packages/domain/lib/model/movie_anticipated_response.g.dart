// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_anticipated_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieAnticipatedResponse _$MovieAnticipatedResponseFromJson(
        Map<String, dynamic> json) =>
    MovieAnticipatedResponse(
      json['list_count'] as num?,
      Movie.fromJson(json['movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieAnticipatedResponseToJson(
        MovieAnticipatedResponse instance) =>
    <String, dynamic>{
      'list_count': instance.listCount,
      'movie': instance.movie.toJson(),
    };
