import 'package:cine_tfg_app/presentation/providers/providers.dart';
import 'package:cine_tfg_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);


    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
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
            movies: popularMovies,
            title: 'Populares',
            //subTitle: 'Domingo 5',
            loadNextPage: () {
              ref.read(popularMoviesProvider.notifier).loadNextPage();
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
      
      
    );
  }
}