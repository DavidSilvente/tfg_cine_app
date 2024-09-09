import 'package:cine_tfg_app/domain/entities/video_post.dart';

abstract class VideoDataSource {
  Future<List<VideoPost>> getVideosByMovieId(String movieId);
}