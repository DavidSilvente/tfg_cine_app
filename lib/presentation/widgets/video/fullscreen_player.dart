import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    
    // Extraer el video ID de YouTube de la URL
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!, // Se espera que el video ID no sea null
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.caption)),
      body: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
      ),
    );
  }
}
