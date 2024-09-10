import 'package:cine_tfg_app/domain/entities/video_post.dart';
import 'package:cine_tfg_app/domain/repositories/video_repository.dart';
import 'package:cine_tfg_app/infrastructure/repositories/movie_repository_impl.dart';
import 'package:cine_tfg_app/presentation/providers/providers.dart';
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
  final MovieRepositoryImpl movieRepository;

  DiscoverNotifier(this.videoPostRepository, this.movieRepository)
      : super(DiscoverState(initialLoading: true, videos: []));

   // Método para cargar los trailers de las películas en cines
  Future<void> loadNowPlayingWithTrailers() async {
    try {
      // 1. Obtener las películas que están en cines desde el datasource
      final nowPlayingMovies = await movieRepository.getNowPlaying();

      // 2. Para cada película, obtener solo un trailer
      final List<VideoPost> trailers = [];

      for (final movie in nowPlayingMovies) {
        final movieTrailers = await videoPostRepository.getVideosByMovieId(movie.id.toString());

        if (movieTrailers.isNotEmpty) {
          // Solo agregamos un trailer por película
          trailers.add(movieTrailers.first);
        }
      }

      // 3. Actualizar el estado con los trailers obtenidos
      state = state.copyWith(
        initialLoading: false,
        videos: [...state.videos, ...trailers],
      );
    } catch (e) {
      state = state.copyWith(initialLoading: false);
      print('Error al cargar los videos: $e');
    }
  }
}
// Provider que utiliza Riverpod para exponer el Notifier
final discoverProvider = StateNotifierProvider<DiscoverNotifier, DiscoverState>(
  (ref) {
    final videoPostRepository = ref.watch(videoPostRepositoryProvider); // Obtenemos el repositorio de videos
    final moviesDatasource = ref.watch(movieRepositoryProvider); // Obtenemos el datasource de películas
    return DiscoverNotifier(videoPostRepository, moviesDatasource);
  },
);
