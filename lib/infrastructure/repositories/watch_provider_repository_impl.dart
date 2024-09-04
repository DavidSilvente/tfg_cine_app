import 'package:cine_tfg_app/domain/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/domain/entities/watch_provider.dart';
import 'package:cine_tfg_app/domain/repositories/watch_provider_repository.dart';

class WatchProviderRepositoryImpl implements WatchProviderRepository {
  
  final WatchProviderDatasource datasource;

  WatchProviderRepositoryImpl(this.datasource);

  @override
  Future<List<WatchProvider>> getWatchProviders(String region, ) {
    return datasource.getWatchProviders(region);
  }
  
  @override
  Future<void> saveWatchProviderId(String providerId) async {
    return datasource.saveWatchProviderId(providerId);
  }

  @override
  Future<String?> getWatchProviderId() async {
    return datasource.getWatchProviderId();
  }
}
