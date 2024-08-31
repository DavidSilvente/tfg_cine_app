import 'package:cine_tfg_app/config/helpers/human_format.dart';
import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/presentation/providers/tv/tv_info_provider.dart';
import 'package:cine_tfg_app/presentation/widgets/actors/actors_by_movie.dart';
import 'package:cine_tfg_app/presentation/widgets/movies/similar_movies.dart';
import 'package:cine_tfg_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cine_tfg_app/presentation/providers/providers.dart';



class TvScreen extends ConsumerStatefulWidget {

  static const name = 'tv-screen';

  final String tvId;

  const TvScreen({
    super.key, 
    required this.tvId
  });

  @override
  TvScreenState createState() => TvScreenState();
}

class TvScreenState extends ConsumerState<TvScreen> {

  @override
  void initState() {
    super.initState();
    
    ref.read(tvInfoProvider.notifier).loadMovie(widget.tvId);
    //ref.read(actorsByMovieProvider.notifier).loadActors(widget.tvId);

  }

  @override
  Widget build(BuildContext context) {

    final Tv? tv = ref.watch( tvInfoProvider )[widget.tvId];

    if ( tv == null ) {
      return const Scaffold(body: Center( child: CircularProgressIndicator( strokeWidth: 2)));
    }


    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(tv: tv),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _TvDetails(tv: tv),
            childCount: 1
          ))
        ],
      ),
    );
  }
}


class _TvDetails extends StatelessWidget {
  
  final Tv tv;

  const _TvDetails({required this.tv});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _TitleAndOverview(tv: tv, size: size, textStyles: textStyles),

        
        // Generos de la película
        _Genres(tv: tv),

        //ActorsByMovie(movieId: tv.id.toString() ),

        //SimilarMovies(movieId: tv.id),

        const SizedBox(height: 50 ),
      ],
    );
  }
}

class _TitleAndOverview extends StatelessWidget {
  const _TitleAndOverview({
    required this.tv,
    required this.size,
    required this.textStyles,
  });

  final Tv tv;
  final Size size;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              tv.posterPath,
              width: size.width * 0.3,
            ),
          ),
    
          const SizedBox( width: 10 ),
    
          // Descripción
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( tv.name, style: textStyles.titleLarge ),
                Text( tv.overview ),

                const SizedBox(height: 10,),

                MovieRating(voteAverage: tv.voteAverage),

                Row(
                  children: [
                    const Text('Estreno:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 5),
                    Text(HumanFormats.shortDate(tv.firstAirDate))
                  ],
                )
              ],
            ),
          )
    
        ],
      ),
    );
  }
}

class _Genres extends StatelessWidget {
  const _Genres({
    required this.tv,
  });

  final Tv tv;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            ...tv.genreIds.map((gender) => Container(
              margin: const EdgeInsets.only( right: 10),
              child: Chip(
                label: Text( gender ),
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int tvId) {

  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository.isMovieFavorite(tvId);
});

class _CustomSliverAppBar extends ConsumerWidget {

  final Tv tv;

  const _CustomSliverAppBar({
    required this.tv
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final isFavoriteFuture = ref.watch(isFavoriteProvider(tv.id));

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async{
           

            //await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(tv);
            ref.invalidate(isFavoriteProvider(tv.id));
          },
          icon: isFavoriteFuture.when(
            data: (isFavorite) => isFavorite
            ? const Icon(Icons.favorite_rounded, color: Colors.red)
            : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
            loading: () => const CircularProgressIndicator(strokeWidth: 2,)
            )
        ),
        IconButton(onPressed: () {

        },
        icon: const Icon(Icons.bookmark_border))
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0),
        title:  _CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 1.0],
          colors: [
            Colors.transparent,
            scaffoldBackgroundColor
          ]
        ),
        background: Stack(
          children: [
            

            SizedBox.expand(
              child: Image.network(
                tv.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if ( loadingProgress != null ) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            const _CustomGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, stops: [0.0, 0.2], colors: [Colors.black54,Colors.transparent]),
            const _CustomGradient(begin: Alignment.topLeft, stops: [0.0, 0.3], colors: [Colors.black87,Colors.transparent]),
            _CustomGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.7, 1.0], colors: [Colors.transparent, scaffoldBackgroundColor]),

          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors});

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: begin,
                    end: end,
                    stops: stops,
                    colors: colors
                  )
                )
              ),
            );
  }
}