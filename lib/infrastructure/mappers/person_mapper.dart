import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/infrastructure/mappers/mappers.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_person.dart';

class PersonMapper {
  static Person movieDBToEntity(PersonMovieDB personDb) {
    return Person(
      id: personDb.id,
      name: personDb.name,
      profilePath: personDb.profilePath.isNotEmpty
          ? "https://image.tmdb.org/t/p/w500${personDb.profilePath}"
          : 'https://www.example.com/default_profile_image.jpg', // Imagen por defecto si no hay
      popularity: personDb.popularity,
      knownForDepartment: personDb.knownForDepartment,
      adult: personDb.adult,
      knownFor: personDb.knownFor.map((movieDb) => MovieMapper.movieDBToEntity(movieDb)).toList(),
    );
  }
}