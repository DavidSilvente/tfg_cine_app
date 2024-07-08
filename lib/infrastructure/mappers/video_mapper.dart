import 'package:cine_tfg_app/domain/entities/video.dart';
import 'package:cine_tfg_app/infrastructure/models/models.dart';

class VideoMapper {
  static moviedbVideoToEntity( Result moviedbVideo ) => Video(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );
}