import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cine_tfg_app/domain/datasources/video_datasource.dart';
import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:cine_tfg_app/infrastructure/mappers/mappers.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_video.dart';


class VideoMoviedbDatasource implements VideoDataSource {
  final String apiKey;

  VideoMoviedbDatasource({required this.apiKey});

  @override
  Future<List<VideoPost>> getVideosByMovieId(String movieId) async {
  final String url =
      'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=es-ES';
  
  // Debug 1: Imprime la URL generada para asegurarte de que está bien formada
  print('Requesting videos from: $url');

  final response = await http.get(Uri.parse(url));

  // Debug 2: Verifica el código de estado de la respuesta
  print('Response status code: ${response.statusCode}');
  
  // Debug 3: Imprime el cuerpo de la respuesta
  print('Response body: ${response.body}');

  if (response.statusCode != 200) {
    throw Exception('Error al cargar videos: ${response.statusCode}');
  }

  // Debug 4: Verifica si el JSON tiene los resultados esperados
  final jsonResponse = jsonDecode(response.body);
  if (jsonResponse['results'] == null || jsonResponse['results'].isEmpty) {
    print('No videos found for this movie.');
  } else {
    print('Found videos: ${jsonResponse['results']}');
  }

  final List<MovieDBVideo> tmdbVideos = (jsonResponse['results'] as List)
      .map((video) => MovieDBVideo.fromJson(video))
      .toList();

  return tmdbVideos.map((tmdbVideo) => VideoMapper.tmdbToEntity(tmdbVideo)).toList();
}

}
