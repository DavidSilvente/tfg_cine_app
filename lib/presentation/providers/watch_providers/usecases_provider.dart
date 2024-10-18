// presentation/providers/usecases_providers.dart
import 'package:cine_tfg_app/domain/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/domain/repositories/watch_provider_repository.dart';
import 'package:cine_tfg_app/infrastructure/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/infrastructure/repositories/watch_provider_repository_impl.dart';
import 'package:cine_tfg_app/presentation/providers/watch_providers/watch_provider_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_tfg_app/domain/usecases/get_watch_provider_id.dart';
import 'package:cine_tfg_app/domain/usecases/save_watch_provider_id.dart';


final watchProviderDatasourceProvider = Provider<WatchProviderDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return WatchProviderDatasourceImpl(dio);
});

final watchProviderRepositoryProvider = Provider<WatchProviderRepository>((ref) {
  final datasource = ref.watch(watchProviderDatasourceProvider);
  return WatchProviderRepositoryImpl(datasource);
});

final getWatchProviderIdProvider = Provider<GetWatchProviderId>((ref) {
  final repository = ref.watch(watchProviderRepositoryProvider);
  return GetWatchProviderId(repository);
});

final saveWatchProviderIdProvider = Provider<SaveWatchProviderId>((ref) {
  final repository = ref.watch(watchProviderRepositoryProvider);
  return SaveWatchProviderId(repository);
});
