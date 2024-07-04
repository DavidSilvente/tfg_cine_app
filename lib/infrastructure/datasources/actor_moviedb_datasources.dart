import 'package:cine_tfg_app/config/constants/environment.dart';
import 'package:cine_tfg_app/domain/datasources/actors_datasources.dart';
import 'package:cine_tfg_app/domain/entities/actor.dart';
import 'package:cine_tfg_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';



class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.movieDBKey,
      "language": "es-ES"
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    
    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();
    
    return actors;
  }

}