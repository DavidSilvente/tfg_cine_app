import 'package:cine_tfg_app/infrastructure/datasources/actor_moviedb_datasources.dart';
import 'package:cine_tfg_app/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositorio inmutable. Solo lectura
final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});