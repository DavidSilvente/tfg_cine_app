import 'package:cine_tfg_app/presentation/providers/providers.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_provider.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_slideshow_provider.dart';
import 'package:cine_tfg_app/presentation/providers/watch_providers/watch_provider_provider.dart';
import 'package:cine_tfg_app/presentation/widgets/tvs/tv_horizontal_listview.dart';
import 'package:cine_tfg_app/presentation/widgets/tvs/tv_slideshow.dart';
import 'package:cine_tfg_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  bool showMovies = true; // Estado para controlar si mostrar películas o series
  String? selectedWatchProvider; // Estado para el Watch Provider seleccionado

  @override
  void initState() {
    super.initState();
    
    // Cargar las películas y series
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    //ref.read(popularMoviesProvider.notifier).loadNextPage();
    //ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    //ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    //ref.read(moviesOfActionInSpainProvider.notifier).loadNextPage();
    //ref.read(getDecadaDeLos90Provider.notifier).loadNextPage();
    //ref.read(airingTodayProvider.notifier).loadNextPage();
    //ref.read(serieFinDeSemanaProvider.notifier).loadNextPage();
    //ref.read(getDecadaDeLos80Provider.notifier).loadNextPage();

    // Cargar los Watch Providers
    ref.read(watchProvidersProvider);
  }

  void toggleFilter() {
    setState(() {
      showMovies = !showMovies; // Cambia el estado al presionar el botón
    });
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    
    // Obtener los Watch Providers
    final watchProvidersAsync = ref.watch(watchProvidersProvider);

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    //final topRatedMovies = ref.watch(topRatedMoviesProvider);
    //final upcomingMovies = ref.watch(upcomingMoviesProvider);
    //final moviesOfAction = ref.watch(moviesOfActionInSpainProvider);
    //final decadaDeLos90 = ref.watch(getDecadaDeLos90Provider);
    //final decadaDeLos80 = ref.watch(getDecadaDeLos80Provider);
    //final slideShowTvs = ref.watch(tvSlideshowProvider);
    //final airingToday = ref.watch(airingTodayProvider);
    //final serieFinDeSemana = ref.watch(serieFinDeSemanaProvider);

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
                    ElevatedButton(
                      onPressed: toggleFilter,
                      child: Text(showMovies ? 'Mostrar Series' : 'Mostrar Películas'),
                    ),
                    watchProvidersAsync.when(
                      data: (watchProviders) {
                        return DropdownButton<String>(
  hint: const Text("Selecciona un proveedor"),
  value: selectedWatchProvider,
  items: watchProviders.map((provider) {
    return DropdownMenuItem<String>(
      value: provider.id.toString(),
      child: Text(provider.name),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      selectedWatchProvider = value;
    });

    // Recargar las películas con el nuevo proveedor seleccionado
    ref.read(nowPlayingMoviesProvider.notifier).reloadMovies(watchProviderId: selectedWatchProvider);
                            //ref.read(popularMoviesProvider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(topRatedMoviesProvider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(upcomingMoviesProvider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(moviesOfActionInSpainProvider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(getDecadaDeLos90Provider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(airingTodayProvider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(serieFinDeSemanaProvider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                            //ref.read(getDecadaDeLos80Provider.notifier).loadNextPage(watchProviderId: selectedWatchProvider);
                          },
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (err, stack) => Text('Error: $err'),
                    ),
                    if (showMovies) ...[
                      MoviesSlideShow(movies: slideShowMovies),
                      MovieHorizontalListview(
                        movies: nowPlayingMovies,
                        title: 'En cines',
                        loadNextPage: () {
                          ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                        },
                      ),
                    ],
                    //  MovieHorizontalListview(
                    //    movies: upcomingMovies,
                    //    title: 'Próximamente',
                    //    loadNextPage: () {
                    //      ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //  MovieHorizontalListview(
                    //    movies: topRatedMovies,
                    //    title: 'Mejor calificadas',
                    //    loadNextPage: () {
                    //      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //  MovieHorizontalListview(
                    //    movies: moviesOfAction,
                    //    title: 'Películas de Acción',
                    //    loadNextPage: () {
                    //      ref.read(moviesOfActionInSpainProvider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //  MovieHorizontalListview(
                    //    movies: decadaDeLos90,
                    //    title: 'Década de los 90',
                    //    loadNextPage: () {
                    //      ref.read(getDecadaDeLos90Provider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //  MovieHorizontalListview(
                    //    movies: decadaDeLos80,
                    //    title: 'Década de los 80',
                    //    loadNextPage: () {
                    //      ref.read(getDecadaDeLos80Provider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //] else ...[
                    //  TvSlideShow(tvs: slideShowTvs),
                    //  TvHorizontalListview(
                    //    tvs: airingToday,
                    //    title: 'Airing Today',
                    //    loadNextPage: () {
                    //      ref.read(airingTodayProvider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //  TvHorizontalListview(
                    //    tvs: serieFinDeSemana,
                    //    title: 'Series para ver en un fin de semana',
                    //    loadNextPage: () {
                    //      ref.read(serieFinDeSemanaProvider.notifier).loadNextPage();
                    //    },
                    //  ),
                    //],
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
