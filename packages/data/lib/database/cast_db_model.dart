final String tableMovies = 'movies';

class CastFields {
  static final List<String> values = [
    id,
    character,
    name,
  ];
  static final String id = '_id';
  static final String character = 'character';
  static final String name = 'name';
}

class Cast {
  final int? id;
  final String? character;
  final String? name;

  Cast({
    this.id,
    this.character,
    this.name,
  });

  Cast copy({int? id}) => Cast(
    id: id ?? this.id,
    character: character ?? this.character,
    name: name ?? this.name,
  );

  static Cast fromJson(Map<String, Object?> json) => Cast(
    id: json[CastFields.id] as int?,
    character: json[CastFields.character] as String?,
    name: json[CastFields.name] as String?,
  );

  Map<String, dynamic> toJson() => {
    CastFields.id: 'id',
    CastFields.character: 'title',
    CastFields.name: 'tmdbid',
  };
}
