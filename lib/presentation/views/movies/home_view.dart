import 'package:cine_tfg_app/presentation/providers/watch_providers/watch_provider_provider.dart';
import 'package:cine_tfg_app/presentation/providers/watch_providers/watch_provider_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_tfg_app/presentation/providers/providers.dart';
import 'package:cine_tfg_app/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  bool showMovies = true; // Estado para controlar si mostrar películas o series

  @override
  void initState() {
    super.initState();
  }

  // Método para alternar entre mostrar películas o series
  void toggleFilter() {
    setState(() {
      showMovies = !showMovies; // Cambia el estado al presionar el botón
    });
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<String?>(selectedWatchProviderIdProvider, (previous, next) {
    if (next != null && previous != next) {
      // Recargar las películas cuando cambie el proveedor
      ref.read(nowPlayingMoviesProvider.notifier).updateMovies(watchProviderId: next);
      ref.read(topRatedMoviesProvider.notifier).updateMovies(watchProviderId: next);
      ref.read(upcomingMoviesProvider.notifier).updateMovies(watchProviderId: next);
      ref.read(moviesOfActionInSpainProvider.notifier).updateMovies(watchProviderId: next);
      ref.read(getDecadaDeLos80Provider.notifier).updateMovies(watchProviderId: next);
      ref.read(getDecadaDeLos90Provider.notifier).updateMovies(watchProviderId: next);
      ref.read(airingTodayProvider.notifier).updateTvs(watchProviderId: next);
      ref.read(serieFinDeSemanaProvider.notifier).updateTvs(watchProviderId: next);
    }
  });

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    
    // Obtener el estado actual del Watch Provider seleccionado
    final selectedWatchProviderId = ref.watch(selectedWatchProviderIdProvider);
    // Obtener los Watch Providers disponibles
    final watchProvidersAsync = ref.watch(watchProvidersProvider);

    // Obtener las películas para el slideshow y las que están en cines
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final moviesOfAction = ref.watch(moviesOfActionInSpainProvider);
    final decadaDeLos90 = ref.watch(getDecadaDeLos90Provider);
    final decadaDeLos80 = ref.watch(getDecadaDeLos80Provider);
    final slideShowTvs = ref.watch(tvSlideshowProvider);
    final airingToday = ref.watch(airingTodayProvider);
    final serieFinDeSemana = ref.watch(serieFinDeSemanaProvider);

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            expandedHeight: 10.0,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomAppbar(),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    // Usar Row para alinear el botón de Mostrar Series y el Dropdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: toggleFilter,
                          child: Text(showMovies ? 'Mostrar Series' : 'Mostrar Películas'),
                        ),
                        watchProvidersAsync.when(
                          data: (watchProviders) {
                            return DropdownButton<String>(
                              hint: const Text("Selecciona un proveedor"),
                              value: selectedWatchProviderId,
                              items: watchProviders.map((provider) {
                                return DropdownMenuItem<String>(
                                  value: provider.id.toString(),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://image.tmdb.org/t/p/w45${provider.logoPath}',
                                        width: 24,
                                        height: 24,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(Icons.error);
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      Text(provider.name),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  // Actualizar el estado global usando el StateNotifier
                                  ref.read(selectedWatchProviderIdProvider.notifier).updateProvider(value);

                                  // Recargar las películas con el nuevo proveedor seleccionado
                                  ref.read(nowPlayingMoviesProvider.notifier).updateMovies(watchProviderId: value);
                                  //ref.read(popularMoviesProvider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(topRatedMoviesProvider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(upcomingMoviesProvider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(moviesOfActionInSpainProvider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(getDecadaDeLos90Provider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(getDecadaDeLos80Provider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(airingTodayProvider.notifier).loadNextPage(watchProviderId: value);
                                  ref.read(serieFinDeSemanaProvider.notifier).loadNextPage(watchProviderId: value);
                                  
                                }
                              },
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Text('Error: $err'),
                        ),
                      ],
                    ),
                    if (showMovies) ...[
                      MoviesSlideShow(movies: slideShowMovies),
                      MovieHorizontalListview(
                        movies: nowPlayingMovies,
                        title: 'En cines',
                        loadNextPage: () {
                          ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(
                            watchProviderId: selectedWatchProviderId, // Asegurarse de pasar el ID del proveedor aquí
                          );
                        },
                      ),

                      MovieHorizontalListview(
                        movies: upcomingMovies,
                        title: 'Próximamente',
                        loadNextPage: () {
                          ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                        },
                      ),
                      MovieHorizontalListview(
                        movies: topRatedMovies,
                        title: 'Mejor calificadas',
                        loadNextPage: () {
                          ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                        },
                      ),
                      MovieHorizontalListview(
                        movies: moviesOfAction,
                        title: 'Películas de Acción',
                        loadNextPage: () {
                          ref.read(moviesOfActionInSpainProvider.notifier).loadNextPage();
                        },
                      ),
                      MovieHorizontalListview(
                        movies: decadaDeLos90,
                        title: 'Década de los 90',
                        loadNextPage: () {
                          ref.read(getDecadaDeLos90Provider.notifier).loadNextPage();
                        },
                      ),
                      MovieHorizontalListview(
                        movies: decadaDeLos80,
                        title: 'Década de los 80',
                        loadNextPage: () {
                          ref.read(getDecadaDeLos80Provider.notifier).loadNextPage();
                        },
                      ),
                    ] else ...[
                      TvSlideShow(tvs: slideShowTvs),
                      TvHorizontalListview(
                        tvs: airingToday,
                        title: 'Airing Today',
                        loadNextPage: () {
                          ref.read(airingTodayProvider.notifier).loadNextPage();
                        },
                      ),
                      TvHorizontalListview(
                        tvs: serieFinDeSemana,
                        title: 'Series para ver en un fin de semana',
                        loadNextPage: () {
                          ref.read(serieFinDeSemanaProvider.notifier).loadNextPage();
                        },
                      ),
                    ],
                    const SizedBox(height: 10),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
