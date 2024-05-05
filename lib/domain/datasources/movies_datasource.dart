import 'package:cine_tfg_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});

}