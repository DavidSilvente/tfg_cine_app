import 'package:cine_tfg_app/domain/entities/movie.dart';
import 'package:cine_tfg_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cine_tfg_app/presentation/providers/person/search_person_provider.dart';
import 'package:cine_tfg_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          
          child: Row(
            children: [
              
              const Spacer(),

              IconButton(
  onPressed: () {
    final searchedMovies = ref.read(searchedMoviesProvider);
    final searchQuery = ref.read(searchQueryProvider);

    final searchPersons = ref.read(searchedPersonProvider);

    showSearch<Movie?>(
      query: searchQuery,
      context: context,
      delegate: SearchMovieDelegate(
        initialMovies: searchedMovies,
        searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery,
        searchPersons: ref.read(searchedPersonProvider.notifier).searchPersonByQuery,
        searchPersonMovies: ref.read(searchedPersonProvider.notifier).getMoviesByPerson, // Aquí pasamos el callback
      ),
    ).then((result) {
      if (result is Movie) {
        context.push('/home/0/movie/${result.id}');
      } else if (result is List<Movie>) {
        // Aquí manejas las películas del actor o director
      }
    });
  },
  icon: const Icon(Icons.search),
)


            ],
          )
        ),
        )
      );
  }
}