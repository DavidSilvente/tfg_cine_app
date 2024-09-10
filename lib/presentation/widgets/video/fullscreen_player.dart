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
    
    // Extraer el ID del video de YouTube
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false, // Si quieres que el video se reproduzca sin sonido inicialmente
        hideControls: true, // Ocultar los controles nativos de YouTube
        hideThumbnail: true, // Evitar que aparezca la miniatura antes del video
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
    return Stack(
      children: [
        // Contenedor que ajusta el video para que ocupe toda la pantalla en formato vertical
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover, // Forzar el video a cubrir todo el espacio
            child: SizedBox(
              width: MediaQuery.of(context).size.width, // Ajusta el ancho al ancho de la pantalla
              height: MediaQuery.of(context).size.height, // Ajusta la altura al alto de la pantalla
              child: YoutubePlayer(
                controller: _youtubeController,
                aspectRatio: 9 / 16, // Forzar la relación de aspecto vertical 9:16
              ),
            ),
          ),
        ),
        
        // Texto superpuesto al video
        Positioned(
          bottom: 50,
          left: 20,
          child: Text(
            widget.caption,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
