import 'package:cine_tfg_app/presentation/providers/video/discover_provider.dart';
import 'package:cine_tfg_app/presentation/widgets/shared/widgets/video_scrollable_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoverState = ref.watch(discoverProvider);

    return Scaffold(
      body: discoverState.initialLoading
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : VideoScrollableView(videos: discoverState.videos),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Llamamos al método que carga las películas en cines y sus trailers
          ref.read(discoverProvider.notifier).loadNowPlayingWithTrailers();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}