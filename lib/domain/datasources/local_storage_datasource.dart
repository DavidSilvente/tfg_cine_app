

import 'package:cine_tfg_app/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite( int movieId);

  Future<List> loadMovies({int limit = 10, offset = 0}); 

}