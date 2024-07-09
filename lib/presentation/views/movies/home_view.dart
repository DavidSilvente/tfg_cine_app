import 'package:cine_tfg_app/presentation/providers/providers.dart';
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
  }


  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if ( initialLoading ) return const FullScreenLoader();
    
    final slideShowMovies = ref.watch( moviesSlideshowProvider );
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
        floating: true,
        expandedHeight: 10.0, // Ajusta esto según tus necesidades
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
              subTitle: 'Domingo 5',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Proximamente',
              //subTitle: 'Domingo 5',
              loadNextPage: () {
                ref.read(upcomingMoviesProvider.notifier).loadNextPage();
              }
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              //subTitle: 'Domingo 5',
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
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