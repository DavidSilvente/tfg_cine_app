

import 'package:cine_tfg_app/domain/entities/movie.dart';
import 'package:cine_tfg_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

//final popularMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
//  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
//  return MoviesNotifier(
//    fetchMoreMovies: fetchMoreMovies
//  );
//});

//final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
//  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
//  return MoviesNotifier(
//    fetchMoreMovies: fetchMoreMovies
//  );
//});
//
//final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
//  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
//  return MoviesNotifier(
//    fetchMoreMovies: fetchMoreMovies
//  );
//});
//
//final moviesOfActionInSpainProvider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
//  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getMoviesInSpain;
//  return MoviesNotifier(
//    fetchMoreMovies: fetchMoreMovies
//  );
//});
//
//final getDecadaDeLos90Provider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
//  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getDecadaDeLos90;
//  return MoviesNotifier(
//    fetchMoreMovies: fetchMoreMovies
//  );
//});
//
//final getDecadaDeLos80Provider = StateNotifierProvider<MoviesNotifier,List<Movie>>((ref) {
//  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getDecadaDeLos80;
//  return MoviesNotifier(
//    fetchMoreMovies: fetchMoreMovies
//  );
//});


typedef MovieCallback = Future<List<Movie>> Function({int page, String? watchProviderId});


class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  final MovieCallback fetchMoreMovies;
  bool isLoading = false;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage({String? watchProviderId}) async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage, watchProviderId: watchProviderId);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  // Nuevo método para cargar películas según el proveedor sin resetear la lista
  Future<void> updateMovies({String? watchProviderId}) async {
    if (isLoading) return;

    isLoading = true;
    currentPage = 1; // Reinicia a la primera página

    final List<Movie> movies = await fetchMoreMovies(page: currentPage, watchProviderId: watchProviderId);
    state = [...movies]; // Actualiza la lista de películas con los nuevos resultados

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}


