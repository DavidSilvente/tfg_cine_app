

import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final airingTodayProvider = StateNotifierProvider<TvNotifier,List<Tv>>((ref) {
  final fetchMoreMovies = ref.watch(tvRepositoryProvider).getAiringToday;
  return TvNotifier(
    fetchMoreTv: fetchMoreMovies
  );
});

final serieFinDeSemanaProvider = StateNotifierProvider<TvNotifier,List<Tv>>((ref) {
  final fetchMoreMovies = ref.watch(tvRepositoryProvider).serieFinDeSemana;
  return TvNotifier(
    fetchMoreTv: fetchMoreMovies
  );
});



typedef TvCallback = Future<List<Tv>> Function({int page});

class TvNotifier extends StateNotifier<List<Tv>> {
  
  
  int currentPage = 0;
  TvCallback fetchMoreTv;
  bool isLoading = false;
  
  TvNotifier({
    required this.fetchMoreTv,
  }) : super([]);

  Future<void> loadNextPage() async {

    if (isLoading) return;

    isLoading = true;

    currentPage++;

    final List<Tv> tvs = await fetchMoreTv(page: currentPage);
    state = [...state, ...tvs];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;

  }

}

