import 'package:cine_tfg_app/config/constants/environment.dart';
import 'package:cine_tfg_app/domain/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/domain/entities/watch_provider.dart';
import 'package:cine_tfg_app/domain/repositories/watch_provider_repository.dart';
import 'package:cine_tfg_app/infrastructure/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/infrastructure/repositories/watch_provider_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.movieDBKey,
      "language": "es-ES"
    }
  ));
});

final watchProviderDatasourceProvider = Provider<WatchProviderDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return WatchProviderDatasourceImpl(dio);
});

final watchProviderRepositoryProvider = Provider<WatchProviderRepository>((ref) {
  final watchProviderDatasource = ref.watch(watchProviderDatasourceProvider);
  return WatchProviderRepositoryImpl(watchProviderDatasource);
});


final watchProvidersProvider = FutureProvider<List<WatchProvider>>((ref) async {
  final watchProviderRepository = ref.watch(watchProviderRepositoryProvider);
  return watchProviderRepository.getWatchProviders('ES');
});