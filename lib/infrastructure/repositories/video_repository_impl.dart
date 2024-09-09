

import 'package:cine_tfg_app/domain/datasources/video_datasource.dart';
import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:cine_tfg_app/domain/repositories/video_repository.dart';

class VideoPostRepositoryImpl implements VideoRepository {
  final VideoDataSource dataSource;

  VideoPostRepositoryImpl(this.dataSource);

  @override
  Future<List<VideoPost>> getVideosByMovieId(String movieId) {
    return dataSource.getVideosByMovieId(movieId);
  }
}