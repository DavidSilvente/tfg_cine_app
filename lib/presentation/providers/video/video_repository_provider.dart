

import 'package:cine_tfg_app/domain/repositories/video_repository.dart';
import 'package:cine_tfg_app/infrastructure/datasources/video_moviedb_datasource.dart';
import 'package:cine_tfg_app/infrastructure/repositories/video_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoPostRepositoryProvider = Provider<VideoRepository>(
  (ref) {
    // Aquí puedes devolver una instancia concreta del repositorio, ya sea mock o real
    return VideoPostRepositoryImpl(VideoMoviedbDatasource(apiKey: '7f345bd614d076bb7037544fea3cb981'));
  },
);
