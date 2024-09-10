import 'package:cine_tfg_app/domain/entities/entities.dart';

class Person {
  final int id;
  final String name;
  final String profilePath;
  final double popularity;
  final String knownForDepartment;
  final bool adult;
  final List<Movie> knownFor;

  Person({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.knownForDepartment,
    required this.adult,
    required this.knownFor,
  });
}
