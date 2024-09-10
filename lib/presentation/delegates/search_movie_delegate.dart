import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cine_tfg_app/config/helpers/human_format.dart';
import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);
typedef SearchPersonMoviesCallback = Future<List<Movie>> Function(int personId);
typedef SearchPersonCallback = Future<List<Person>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  final SearchPersonCallback searchPersons;
  final SearchPersonMoviesCallback searchPersonMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.searchPersons,
    required this.searchPersonMovies,
    required this.initialMovies,
  }) : super(searchFieldLabel: 'Buscar películas');

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
  isLoadingStream.add(true);

  if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

  _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
    // Realizamos ambas búsquedas simultáneamente
    final moviesFuture = searchMovies(query);
    final personsFuture = searchPersons(query);

    // Esperamos ambas búsquedas al mismo tiempo
    final results = await Future.wait([moviesFuture, personsFuture]);

    final List<Movie> movies = results[0] as List<Movie>;
    final List<Person> persons = results[1] as List<Person>;

    // Usamos un Set para evitar duplicados, verificando el ID de la película
    final Set<int> movieIds = {};  // Para almacenar solo IDs únicos
    final List<Movie> uniqueMovies = [];  // Lista final sin duplicados

    // Añadimos las películas encontradas por nombre
    for (final movie in movies) {
      if (!movieIds.contains(movie.id)) {
        movieIds.add(movie.id);
        uniqueMovies.add(movie);
      }
    }

    // Si encontramos personas, obtenemos sus películas y las añadimos
    if (persons.isNotEmpty) {
      for (final person in persons) {
        final moviesByPerson = await searchPersonMovies(person.id);

        for (final movie in moviesByPerson) {
          // Solo agregamos la película si no está ya en el Set
          if (!movieIds.contains(movie.id)) {
            movieIds.add(movie.id);
            uniqueMovies.add(movie);
          }
        }
      }
    }

    // Enviamos la lista sin duplicados al stream
    debouncedMovies.add(uniqueMovies);

    isLoadingStream.add(false);
  });
}



  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.refresh_rounded),
            );
          }

          return IconButton(
            onPressed: () => query = '',
            icon: const Icon(Icons.clear),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: FadeIn(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [

              // Image
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    height: 130,
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.posterPath),
                    placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                  )
                ),
              ),
    
            const SizedBox(width: 10),
              
              // Description
              SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( movie.title, style: textStyles.titleMedium ),

                    ( movie.overview.length > 100 )
                      ? Text( '${movie.overview.substring(0,100)}...' )
                      : Text( movie.overview ),

                    Row(
                      children: [
                        Icon( Icons.star_half_rounded, color: Colors.yellow.shade800 ),
                        const SizedBox(width: 5),
                        Text( 
                          HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900 ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}