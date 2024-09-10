import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/domain/repositories/person_repository.dart';
import 'package:cine_tfg_app/domain/datasources/person_datasource.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonDataSource dataSource;

  PersonRepositoryImpl(this.dataSource);

  @override
  Future<List<Person>> searchPerson(String query) {
    return dataSource.searchPerson(query);
  }

  @override
  Future<List<Movie>> getPersonMovies(int personId) {
    return dataSource.getPersonMovies(personId);
  }
}