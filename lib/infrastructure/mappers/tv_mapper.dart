

import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_tv.dart';

class TvMapper {
  static Tv tvDBToEntity (TvMovieDB tvdb) => Tv(
    adult: tvdb.adult,
    backdropPath: tvdb.backdropPath != "" ? "https://image.tmdb.org/t/p/w500${tvdb.backdropPath}" : "",
    genreIds: tvdb.genreIds,
    id: tvdb.id,
    originCountry: tvdb.originCountry,
    originalLanguage: tvdb.originalLanguage,
    originalName: tvdb.originalName,
    overview: tvdb.overview,
    popularity: tvdb.popularity,
    posterPath: tvdb.posterPath != "" ? "https://image.tmdb.org/t/p/w500${tvdb.posterPath}" : "",
    firstAirDate: tvdb.firstAirDate,
    name: tvdb.name,
    voteAverage: tvdb.voteAverage,
    voteCount: tvdb.voteCount
    );
}