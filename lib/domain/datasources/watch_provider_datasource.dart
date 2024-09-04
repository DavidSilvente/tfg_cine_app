import 'package:cine_tfg_app/domain/entities/watch_provider.dart';

abstract class WatchProviderDatasource {
  Future<List<WatchProvider>> getWatchProviders(String region);

  Future<void> saveWatchProviderId(String providerId);
  Future<String?> getWatchProviderId();
}