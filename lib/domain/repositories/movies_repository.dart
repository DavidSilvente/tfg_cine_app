import 'package:cine_tfg_app/domain/entities/entities.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1, String? watchProviderId});
  Future<List<Movie>> getPopular({int page = 1, String? watchProviderId});
  Future<List<Movie>> getTopRated({int page = 1, String? watchProviderId});
  Future<List<Movie>> getUpcoming({int page = 1, String? watchProviderId});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searchMovies(String query);
  Future<List<Movie>> getSimilarMovies(int movieId);
  Future<List<Movie>> getMoviesInSpain({int page = 1, String? watchProviderId});
  Future<List<Movie>> getDecadaDeLos90({int page = 1, String? watchProviderId});
  Future<List<Movie>> getDecadaDeLos80({int page = 1, String? watchProviderId});
  

}