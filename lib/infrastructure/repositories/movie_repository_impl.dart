import 'package:cine_tfg_app/domain/datasources/movies_datasource.dart';
import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource moviesDatasource;

  MovieRepositoryImpl(this.moviesDatasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    
    return moviesDatasource.getNowPlaying(page: page);

  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return moviesDatasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return moviesDatasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return moviesDatasource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return moviesDatasource.getMovieById(id);
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) {
    return moviesDatasource.searchMovies(query);
  }
  
  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return moviesDatasource.getSimilarMovies(movieId);
  }
  
  @override
  Future<List<Movie>> getMoviesInSpain({int page = 1}) {
    return moviesDatasource.getMoviesInSpain(page: page);
  }
  
  @override
  Future<List<Movie>> getDecadaDeLos90({int page = 1}) {
    return moviesDatasource.getDecadaDeLos90(page: page);
  }

  @override
  Future<List<Movie>> getDecadaDeLos80({int page = 1}) {
    return moviesDatasource.getDecadaDeLos80(page: page);
  }

}