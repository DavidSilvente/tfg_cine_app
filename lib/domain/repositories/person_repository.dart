import 'package:cine_tfg_app/domain/entities/entities.dart';

abstract class PersonRepository {
  Future<List<Person>> searchPerson(String query);
  Future<List<Movie>> getPersonMovies(int personId);
}
