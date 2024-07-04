import 'package:cine_tfg_app/domain/entities/actor.dart';
import 'package:cine_tfg_app/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  
  final actorRepository = ref.watch(actorRepositoryProvider);

  return ActorsByMovieNotifier(getActors: actorRepository.getActorsByMovie);
});


typedef GetActorCallvack = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {

  final GetActorCallvack getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }): super({});

  Future<void> loadActors(String movieId) async {
    if ( state[movieId] != null ) return;

    final actors = await getActors(movieId);

    //Clonar estado y movieId apunta a movie
    state = {...state, movieId: actors};
  }
}