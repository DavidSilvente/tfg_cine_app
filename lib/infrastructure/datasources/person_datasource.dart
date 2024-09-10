import 'dart:convert';
import 'package:cine_tfg_app/infrastructure/mappers/mappers.dart';
import 'package:cine_tfg_app/infrastructure/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:cine_tfg_app/domain/datasources/person_datasource.dart';
import 'package:cine_tfg_app/domain/entities/entities.dart';
import 'package:cine_tfg_app/infrastructure/mappers/person_mapper.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_person.dart';

class PersonDatasource implements PersonDataSource {

  @override
  Future<List<Movie>> getPersonMovies(int personId) async {
    final url = Uri.https('api.themoviedb.org', '/3/person/$personId/movie_credits', {
      'api_key': '7f345bd614d076bb7037544fea3cb981'
    });

    final response = await http.get(url);

    // Imprimir el estado de la respuesta
    print('Response status code (getPersonMovies): ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Imprimir el cuerpo de la respuesta
      print('Response body (getPersonMovies): ${response.body}');

      final List cast = jsonResponse['cast'];  // Actuaciones
      final List crew = jsonResponse['crew'];  // Dirección o equipo

      // Combinar actores y crew en una sola lista y mapear con el nuevo mapper
      final List allCredits = [...cast, ...crew];

      // Imprimir el contenido de allCredits
      print('Movies (cast and crew combined): $allCredits');

      return allCredits.map((movieData) {
        final movieDB = MovieMovieDB.fromJson(movieData);  // Mapea a tu modelo
        return MovieMapper.movieCreditsToEntity(movieDB);  // Luego usa el mapper
      }).toList();
    } else {
      throw Exception('Error al obtener las películas de la persona');
    }
  }

  @override
  Future<List<Person>> searchPerson(String query) async {
    final url = Uri.https('api.themoviedb.org', '/3/search/person', {
      'query': query,
      'api_key': '7f345bd614d076bb7037544fea3cb981'
    });

    final response = await http.get(url);

    // Imprimir el estado de la respuesta
    print('Response status code (searchPerson): ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      // Imprimir el cuerpo de la respuesta
      print('Response body (searchPerson): ${response.body}');

      final List results = jsonResponse['results'];

      // Usar el mapper para convertir los resultados
      return results.map((personData) => PersonMapper.movieDBToEntity(PersonMovieDB.fromJson(personData))).toList();
    } else {
      throw Exception('Error al buscar personas');
    }
  }
}
