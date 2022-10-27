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

class CastAndImages {
  final String? character;
  final String? name;
  final String? image;
  final int? trakt;

  CastAndImages(
    this.character,
    this.name,
    this.image,
    this.trakt,
  );

  static CastAndImages fromResponse(Map<String, Object?> json) => CastAndImages(
        json['character'] as String?,
        json['name'] as String?,
        json['image'] as String?,
        json['trakt'] as int?,
      );

  Map<String, dynamic> toJson(CastAndImages cast) => {
        CastFields.character: cast.character,
        CastFields.name: cast.name,
        CastFields.image: cast.image,
        CastFields.trakt: cast.trakt,
      };
}
