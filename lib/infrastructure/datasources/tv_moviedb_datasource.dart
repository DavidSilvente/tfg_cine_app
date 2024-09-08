import 'package:cine_tfg_app/config/constants/environment.dart';
import 'package:cine_tfg_app/domain/datasources/tv_datasource.dart';
import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/infrastructure/mappers/tv_mapper.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/tv_details.dart';
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

  List<Tv> _jsonToTv(Map<String,dynamic> json) {
    final tvDbResponse = TvMovieDbResponse.fromJson(json);

    final List<Tv> tvs = tvDbResponse.results.map((tvdb) => TvMapper.tvDBToEntity(tvdb)).toList();
  
    return tvs;

  }

  @override
Future<List<Tv>> getAiringToday({int page = 1, String? watchProviderId}) async {
  final queryParameters = {
    'page': page,
    'region': 'ES',
    if (watchProviderId != null) 'with_watch_providers': watchProviderId,
    'watch_region': 'ES',
  };

  final response = await dio.get("/discover/tv", queryParameters: queryParameters);

  return _jsonToTv(response.data);
}

@override
Future<List<Tv>> getOnTheAir({int page = 1, String? watchProviderId}) async {
  final queryParameters = {
    'page': page,
    'region': 'ES',
    if (watchProviderId != null) 'with_watch_providers': watchProviderId,
    'watch_region': 'ES',
  };

  final response = await dio.get("/discover/tv", queryParameters: queryParameters);

  return _jsonToTv(response.data);
}

@override
Future<List<Tv>> getPopular({int page = 1, String? watchProviderId}) async {
  final queryParameters = {
    'page': page,
    'region': 'ES',
    if (watchProviderId != null) 'with_watch_providers': watchProviderId,
    'watch_region': 'ES',
  };

  final response = await dio.get("/discover/tv", queryParameters: queryParameters);

  return _jsonToTv(response.data);
}

@override
Future<List<Tv>> getTopRated({int page = 1, String? watchProviderId}) async {
  final queryParameters = {
    'page': page,
    'region': 'ES',
    if (watchProviderId != null) 'with_watch_providers': watchProviderId,
    'watch_region': 'ES',
  };

  final response = await dio.get("/discover/tv", queryParameters: queryParameters);

  return _jsonToTv(response.data);
}

  @override
  Future<List<Tv>> serieFinDeSemana({int page = 1, String? watchProviderId,}) async {
    final response = await dio.get("/discover/tv",
    queryParameters: {
      'page': page,
      'watch_region': 'ES',
      'with_watch_providers': '8|9|337|384|350|35',
      'with_status': '0', // 0 para series en emisión
      'sort_by': 'popularity.desc', // Ordena por popularidad
    });

  return _jsonToTv(response.data);
}

  @override
  Future<Tv> getTvById(String id) async {
    final response = await dio.get('/tv/$id');
    if ( response.statusCode != 200 ) throw Exception('Movie with id: $id not found');

    
    final tvDetails = TvDetails.fromJson( response.data );
    final Tv tv = TvMapper.tvDetailsToEntity(tvDetails);
    return tv;
  }

}