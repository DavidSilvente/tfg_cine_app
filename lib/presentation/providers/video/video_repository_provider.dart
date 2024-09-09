

import 'package:cine_tfg_app/domain/repositories/video_repository.dart';
import 'package:cine_tfg_app/infrastructure/datasources/video_moviedb_datasource.dart';
import 'package:cine_tfg_app/infrastructure/repositories/video_repository_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoPostRepositoryProvider = Provider<VideoRepository>(
  (ref) {
    final apiKey = dotenv.env['MOVIEDB_KEY'] ?? '';
    // Aquí puedes devolver una instancia concreta del repositorio, ya sea mock o real
    return VideoPostRepositoryImpl(VideoMoviedbDatasource(apiKey: apiKey));
  },
);
