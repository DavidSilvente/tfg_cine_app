import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:cine_tfg_app/domain/repositories/video_repository.dart';
import 'package:cine_tfg_app/presentation/providers/video/video_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Estado que manejará la carga inicial y la lista de videos
class DiscoverState {
  final bool initialLoading;
  final List<VideoPost> videos;

  DiscoverState({
    required this.initialLoading,
    required this.videos,
  });

  // Método para copiar el estado y actualizar las propiedades deseadas
  DiscoverState copyWith({
    bool? initialLoading,
    List<VideoPost>? videos,
  }) {
    return DiscoverState(
      initialLoading: initialLoading ?? this.initialLoading,
      videos: videos ?? this.videos,
    );
  }
}

// Notifier que controlará el estado de Discover
class DiscoverNotifier extends StateNotifier<DiscoverState> {
  final VideoRepository videoPostRepository;

  DiscoverNotifier(this.videoPostRepository)
      : super(DiscoverState(initialLoading: true, videos: []));

  // Método para cargar la siguiente página de videos
  Future<void> loadNextPage(String movieId) async {
    try {
      final newVideos = await videoPostRepository.getVideosByMovieId(movieId);
      
      // Actualizamos el estado añadiendo los nuevos videos
      state = state.copyWith(
        initialLoading: false,
        videos: [...state.videos, ...newVideos],
      );
    } catch (e) {
      // Manejo de errores (puedes modificar esto si quieres manejar los errores de forma más específica)
      state = state.copyWith(initialLoading: false);
      print('Error al cargar los videos: $e');
    }
  }
}

// Provider que utiliza Riverpod para exponer el Notifier
final discoverProvider = StateNotifierProvider<DiscoverNotifier, DiscoverState>(
  (ref) {
    final videoPostRepository = ref.watch(videoPostRepositoryProvider); // Obtenemos el repositorio desde Riverpod
    return DiscoverNotifier(videoPostRepository);
  },
);
