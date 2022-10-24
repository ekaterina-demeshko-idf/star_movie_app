const String tableMovies = 'movies';

class CastFields {
  static final List<String> values = [
    character,
    name,
    image,
    trakt,
  ];

  static const String character = 'character';
  static const String name = 'name';
  static const String image = 'image';

  static const String trakt = 'trakt';
}

class CastCache {
  final String? character;
  final String? name;
  final String? image;
  final int? trakt;

  CastCache(
      this.character,
      this.name,
      this.image,
      this.trakt,
      );

  static CastCache fromResponse(Map<String, Object?> json) => CastCache(
    json['character'] as String?,
    json['name'] as String?,
    json['image'] as String?,
    json['trakt'] as int?,
  );

  Map<String, dynamic> toJson(CastCache cast) => {
    CastFields.character: cast.character,
    CastFields.name: cast.name,
    CastFields.image: cast.image,
    CastFields.trakt: cast.trakt,
  };
}
