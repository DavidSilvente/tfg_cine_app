import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:cine_tfg_app/infrastructure/models/moviedb/moviedb_video.dart';


class VideoMapper {
  static VideoPost tmdbToEntity(MovieDBVideo tmdbVideo) {
    return VideoPost(
      caption: tmdbVideo.name,
      videoUrl: _createVideoUrl(tmdbVideo),
      likes: 0, // No hay información de likes en la API de TMDB
      views: 0, // No hay información de views en la API de TMDB
    );
  }

  static String _createVideoUrl(MovieDBVideo tmdbVideo) {
  if (tmdbVideo.site == 'YouTube') {
    final videoUrl = 'https://www.youtube.com/watch?v=${tmdbVideo.key}';
    print('Generated YouTube video URL: $videoUrl'); // Debug para asegurarse de que la URL es correcta
    return videoUrl;
  }
  return '';
}
}
