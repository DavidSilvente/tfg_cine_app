import 'package:cine_tfg_app/domain/repositories/watch_provider_repository.dart';

class SaveWatchProviderId {
  final WatchProviderRepository repository;

  SaveWatchProviderId(this.repository);

  Future<void> call(String providerId) {
    return repository.saveWatchProviderId(providerId);
  }
}