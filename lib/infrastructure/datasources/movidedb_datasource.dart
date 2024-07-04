import 'package:cine_tfg_app/config/constants/environment.dart';
import 'package:cine_tfg_app/domain/datasources/movies_datasource.dart';
import 'package:cine_tfg_app/domain/entities/movie.dart';
import 'package:cine_tfg_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';


class MovieDbDataSource extends MoviesDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.movieDBKey,
      "language": "es-ES"
    }
  ));

  List<Movie> _jsonToMovies(Map<String,dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results.map((moviedb) => MovieMapper.movieDBToEntity(moviedb)).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get("/movie/now_playing",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);


  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    final response = await dio.get("/movie/popular",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async{
    final response = await dio.get("/movie/top_rated",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    
    final response = await dio.get("/movie/upcoming",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);


  }

  @override
  Future<Movie> getMovieById( String id ) async {

    final response = await dio.get('/movie/$id');
    if ( response.statusCode != 200 ) throw Exception('Movie with id: $id not found');
    
    final movieDetails = MovieDetails.fromJson( response.data );
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
  
  
}