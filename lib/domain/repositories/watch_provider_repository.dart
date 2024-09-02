import 'package:cine_tfg_app/domain/entities/watch_provider.dart';

abstract class WatchProviderRepository {
  Future<List<WatchProvider>> getWatchProviders(String region);
}