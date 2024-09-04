import 'package:cine_tfg_app/domain/repositories/watch_provider_repository.dart';

class GetWatchProviderId {
  final WatchProviderRepository repository;

  GetWatchProviderId(this.repository);

  Future<String?> call() {
    return repository.getWatchProviderId();
  }
}