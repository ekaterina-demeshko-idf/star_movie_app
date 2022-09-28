class MoviePresentation {
  final String title;
  final String image;
  final String runtime;
  final double rating;
  final String? genre;
  final String? genres;
  final String? certification;
  final String? overview;
  final int? traktId;
  final int? tmdbId;

  MoviePresentation(
    this.title,
    this.image,
    this.runtime,
    this.rating,
    this.genre,
    this.genres,
    this.certification,
    this.overview,
    this.traktId,
    this.tmdbId,
  );
}
