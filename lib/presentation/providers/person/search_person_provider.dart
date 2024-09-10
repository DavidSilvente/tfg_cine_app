import 'package:cine_tfg_app/presentation/providers/person/person_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_tfg_app/domain/entities/person.dart';
import 'package:cine_tfg_app/domain/entities/movie.dart';

final searchPersonQueryProvider = StateProvider((ref) => '');

// Provider para buscar personas y sus películas
final searchedPersonProvider = StateNotifierProvider<SearchedPersonNotifier, List<Person>>((ref) {
  final personRepository = ref.read(personRepositoryProvider);
  return SearchedPersonNotifier(
    searchPerson: personRepository.searchPerson,
    searchPersonMovies: personRepository.getPersonMovies,
    ref: ref,
  );
});

typedef SearchPersonCallback = Future<List<Person>> Function(String query);
typedef SearchPersonMoviesCallback = Future<List<Movie>> Function(int personId);

class SearchedPersonNotifier extends StateNotifier<List<Person>> {
  final SearchPersonCallback searchPerson;
  final SearchPersonMoviesCallback searchPersonMovies;
  final Ref ref;

  SearchedPersonNotifier({
    required this.searchPerson,
    required this.searchPersonMovies,
    required this.ref,
  }) : super([]);

  // Método para buscar personas por nombre
  Future<List<Person>> searchPersonByQuery(String query) async {
    final List<Person> persons = await searchPerson(query);
    ref.read(searchPersonQueryProvider.notifier).update((state) => query);

    state = persons;
    return persons;
  }

  // Método para obtener las películas de una persona
  Future<List<Movie>> getMoviesByPerson(int personId) async {
    final List<Movie> movies = await searchPersonMovies(personId);
    return movies;
  }
}
