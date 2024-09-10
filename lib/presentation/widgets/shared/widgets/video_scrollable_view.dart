import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:cine_tfg_app/presentation/widgets/shared/widgets/video_buttons.dart';
import 'package:cine_tfg_app/presentation/widgets/video/fullscreen_player.dart';
import 'package:flutter/material.dart';

class VideoScrollableView extends StatelessWidget {
  
  final List<VideoPost> videos;
  
  const VideoScrollableView({
    super.key, 
    required this.videos
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];

        return Stack(
          children: [
            // Video Player + gradiente
            SizedBox.expand(
              child: FullScreenPlayer(
                caption: videoPost.caption,
                videoUrl: videoPost.videoUrl,
              )
            ),

            // Botones
            
            
          ],
        );

      },
    );
  }
}