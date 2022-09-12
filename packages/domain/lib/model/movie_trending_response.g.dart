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

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      title: json['title'] as String?,
      year: json['year'] as int?,
      ids: json['ids'] == null
          ? null
          : Ids.fromJson(json['ids'] as Map<String, dynamic>),
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      released: json['released'] as String?,
      runtime: json['runtime'] as int?,
      country: json['country'] as String?,
      trailer: json['trailer'] as String?,
      homepage: json['homepage'] as String?,
      status: json['status'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      updatedAt: json['updated_at'] as String?,
      language: json['language'] as String?,
      availableTranslations: (json['available_translations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      certification: json['certification'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'year': instance.year,
      'ids': instance.ids,
      'tagline': instance.tagline,
      'overview': instance.overview,
      'released': instance.released,
      'runtime': instance.runtime,
      'country': instance.country,
      'trailer': instance.trailer,
      'homepage': instance.homepage,
      'status': instance.status,
      'rating': instance.rating,
      'votes': instance.votes,
      'comment_count': instance.commentCount,
      'updated_at': instance.updatedAt,
      'language': instance.language,
      'available_translations': instance.availableTranslations,
      'genres': instance.genres,
      'certification': instance.certification,
    };

Ids _$IdsFromJson(Map<String, dynamic> json) => Ids(
      trakt: json['trakt'] as int?,
      slug: json['slug'] as String?,
      imdb: json['imdb'] as String?,
      tmdb: json['tmdb'] as int?,
    );

Map<String, dynamic> _$IdsToJson(Ids instance) => <String, dynamic>{
      'trakt': instance.trakt,
      'slug': instance.slug,
      'imdb': instance.imdb,
      'tmdb': instance.tmdb,
    };
