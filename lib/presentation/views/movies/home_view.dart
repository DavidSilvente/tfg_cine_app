import 'package:cine_tfg_app/presentation/providers/providers.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_provider.dart';
import 'package:cine_tfg_app/presentation/widgets/tvs/tv_horizontal_listview.dart';
import 'package:cine_tfg_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class HomeView extends ConsumerStatefulWidget {
  const HomeView({ super.key });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
    ref.read( moviesOfActionInSpainProvider.notifier).loadNextPage();
    ref.read(getDecadaDeLos90Provider.notifier).loadNextPage();
    ref.read( airingTodayProvider.notifier).loadNextPage();
    ref.read( serieFinDeSemanaProvider.notifier).loadNextPage();
    ref.read(getDecadaDeLos80Provider.notifier).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if ( initialLoading ) return const FullScreenLoader();
    
    final slideShowMovies = ref.watch( moviesSlideshowProvider );
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );
    final moviesOfAction = ref.watch(moviesOfActionInSpainProvider);
    final decadaDeLos90 = ref.watch(getDecadaDeLos90Provider);
    final decadaDeLos80 = ref.watch(getDecadaDeLos80Provider);
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
            MoviesSlideShow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Proximamente',

              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',

              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: moviesOfAction,
              title: 'Peliculas de Acción',

              loadNextPage: () {
                ref.read(moviesOfActionInSpainProvider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: decadaDeLos90,
              title: 'Decada de los 90',

              loadNextPage: () {
                ref.read(getDecadaDeLos90Provider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: decadaDeLos80,
              title: 'Decada de los 80',

              loadNextPage: () {
                ref.read(getDecadaDeLos80Provider.notifier).loadNextPage();
              }
            ),
            TvHorizontalListview(
              tvs: airingToday,
              title: 'Peliculas de Acción',

              loadNextPage: () {
                ref.read(airingTodayProvider.notifier).loadNextPage();
              }
            ),
            TvHorizontalListview(
              tvs: serieFinDeSemana,
              title: 'Peliculas de Acción',

              loadNextPage: () {
                ref.read(serieFinDeSemanaProvider.notifier).loadNextPage();
              }
            ),
            
            const SizedBox(height: 10),
          ],
        );
            },
            childCount: 1
          )),
        ]
      ),
    );
  }
}