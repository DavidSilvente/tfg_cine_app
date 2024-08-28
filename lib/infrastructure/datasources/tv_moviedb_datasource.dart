import 'package:cine_tfg_app/config/constants/environment.dart';
import 'package:cine_tfg_app/domain/datasources/tv_datasource.dart';
import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/infrastructure/mappers/tv_mapper.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/tv_response.dart';
import 'package:dio/dio.dart';

class TvMoviedbDatasource extends TvDatasource{


  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.movieDBKey,
      "language": "es-ES"
    }
  ));

  List<Tv> _jsonToMovies(Map<String,dynamic> json) {
    final tvDbResponse = TvMovieDbResponse.fromJson(json);

    final List<Tv> tvs = tvDbResponse.results.map((tvdb) => TvMapper.tvDBToEntity(tvdb)).toList();
  
    return tvs;

  }

  @override
  Future<List<Tv>> getAiringToday({int page = 1}) async {
    final response = await dio.get("/tv/airing_today",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Tv>> getOnTheAir({int page = 1}) async {
    final response = await dio.get("/tv/on_the_air",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Tv>> getPopular({int page = 1}) async {
    final response = await dio.get("/tv/popular",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Tv>> getTopRated({int page = 1}) async {
    final response = await dio.get("/tv/top_rated",
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Tv>> serieFinDeSemana({int page = 1}) async {
    final response = await dio.get("/discover/tv",
    queryParameters: {
      'page': page,
      'watch_region': 'ES',
      'with_watch_providers': '8|9|337|384|350|35',
      'with_status': '0', // 0 para series en emisión
      'sort_by': 'popularity.desc', // Ordena por popularidad
    });

  return _jsonToMovies(response.data);
}

}