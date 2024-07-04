

import 'package:cine_tfg_app/domain/entities/movie.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_movie.dart';

import '../models/moviedb/movie_details.dart';

class MovieMapper {
  static Movie movieDBToEntity (MovieDBMovie moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: moviedb.backdropPath != "" ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}" : "",
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath:  moviedb.posterPath != "" ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}" : "",
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount
    );

    static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != "" ? "https://image.tmdb.org/t/p/w500${moviedb.backdropPath}" : "",
      genreIds: moviedb.genres.map((e) => e.name ).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath:  moviedb.posterPath != "" ? "https://image.tmdb.org/t/p/w500${moviedb.posterPath}" : "",
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );
}