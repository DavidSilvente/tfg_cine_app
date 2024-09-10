import 'package:cine_tfg_app/infrastructure/models/models.dart';

class PersonMovieDB {
  PersonMovieDB({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.knownForDepartment,
    required this.adult,
    required this.knownFor,
  });

  final int id;
  final String name;
  final String profilePath;
  final double popularity;
  final String knownForDepartment;
  final bool adult;
  final List<MovieMovieDB> knownFor; // Relacionamos con tus películas

  factory PersonMovieDB.fromJson(Map<String, dynamic> json) => PersonMovieDB(
    id: json['id'],
    name: json['name'] ?? 'Unknown Name',
    profilePath: json['profile_path'] ?? '',
    popularity: json['popularity']?.toDouble() ?? 0.0,
    knownForDepartment: json['known_for_department'] ?? '',
    adult: json['adult'] ?? false,
    knownFor: List<MovieMovieDB>.from(json['known_for'].map((x) => MovieMovieDB.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'profile_path': profilePath,
    'popularity': popularity,
    'known_for_department': knownForDepartment,
    'adult': adult,
    'known_for': List<dynamic>.from(knownFor.map((x) => x.toJson())),
  };
}