

import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_tv.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/tv_details.dart';

class TvMapper {
  static Tv tvDBToEntity (TvMovieDB tvdb) => Tv(
    adult: tvdb.adult,
    backdropPath: tvdb.backdropPath != "" ? "https://image.tmdb.org/t/p/w500${tvdb.backdropPath}" : "",
    genreIds: tvdb.genreIds.map((e) => e.toString()).toList(),
    id: tvdb.id,
    originCountry: tvdb.originCountry,
    originalLanguage: tvdb.originalLanguage,
    originalName: tvdb.originalName,
    overview: tvdb.overview,
    popularity: tvdb.popularity,
    posterPath: tvdb.posterPath != "" ? "https://image.tmdb.org/t/p/w500${tvdb.posterPath}" : "",
    firstAirDate: tvdb.firstAirDate != null ? tvdb.firstAirDate! : DateTime.now(),
    name: tvdb.name,
    voteAverage: tvdb.voteAverage,
    voteCount: tvdb.voteCount
    );
  static Tv tvDetailsToEntity(TvDetails tvdb) => Tv(
    adult: tvdb.adult,
    backdropPath: tvdb.backdropPath != "" ? "https://image.tmdb.org/t/p/w500${tvdb.backdropPath}" : "",
    genreIds: tvdb.genres.map((e) => e.name ).toList(),
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