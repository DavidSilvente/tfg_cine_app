class TvMovieDB {
    final bool adult;
    final String backdropPath;
    final List<int> genreIds;
    final int id;
    final List<String> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final DateTime firstAirDate;
    final String name;
    final double voteAverage;
    final int voteCount;

    TvMovieDB({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.firstAirDate,
        required this.name,
        required this.voteAverage,
        required this.voteCount,
    });

    factory TvMovieDB.fromJson(Map<String, dynamic> json) => TvMovieDB(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] ?? '',
        originalName: json["original_name"] ?? '',
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0,
        posterPath: json["poster_path"] ?? '',
        firstAirDate: DateTime.parse(json["first_air_date"]),
        name: json["name"] ?? 'No Title',
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        voteCount: json["vote_count"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "name": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
