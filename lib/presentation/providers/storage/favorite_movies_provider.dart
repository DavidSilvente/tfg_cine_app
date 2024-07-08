import 'package:cine_tfg_app/domain/entities/movie.dart';
import 'package:cine_tfg_app/domain/repositories/local_storage_repository.dart';
import 'package:cine_tfg_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier,Map<int,Movie>>((ref) {

  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  bool isLoading = false;
  final int limit = 12;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    if (isLoading) return [];
    isLoading = true;
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: limit);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for( final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    state = {...state, ...tempMoviesMap};
    await Future.delayed(const Duration(milliseconds: 200));
    isLoading = false;
    return movies;
  }

  Future<void> toggleFavorite( Movie movie ) async { 

    final bool isMovieInFavorites = await localStorageRepository.isMovieFavorite(movie.id);

    await localStorageRepository.toggleFavorite(movie);

    if ( isMovieInFavorites ) {
      state.remove(movie.id);
      state = { ...state };
    } else {
      if (isLoading && state.length >= limit) {
        state = {...state, movie.id: movie};
      }

      if(state.length < limit) state = {...state, movie.id:movie};

      if(state.length > limit && !isLoading) {
        state = {...state, movie.id: movie};
      }
    }
  }
}