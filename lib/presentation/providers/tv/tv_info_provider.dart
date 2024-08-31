import 'package:cine_tfg_app/domain/entities/tv.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvInfoProvider = StateNotifierProvider<TvMapNotifier, Map<String,Tv>>((ref) {
  
  final tvReporository = ref.watch(tvRepositoryProvider);

  return TvMapNotifier(getTv: tvReporository.getTvById);
});


typedef GetMovieCallback = Future<Tv>Function(String tvId);

class TvMapNotifier extends StateNotifier<Map<String, Tv>> {

  final GetMovieCallback getTv;
  TvMapNotifier({
    required this.getTv,
  }): super({});

  Future<void> loadMovie(String tvId) async {
    if ( state[tvId] != null ) return;

    final tv = await getTv(tvId);

    //Clonar estado y movieId apunta a movie
    state = {...state, tvId: tv};
  }
}