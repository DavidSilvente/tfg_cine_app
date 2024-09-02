// data/datasources/watch_provider_datasource_impl.dart
import 'package:cine_tfg_app/domain/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/domain/entities/watch_provider.dart';
import 'package:dio/dio.dart';

class WatchProviderDatasourceImpl implements WatchProviderDatasource {
  final Dio dio;

  WatchProviderDatasourceImpl(this.dio);

  @override
  Future<List<WatchProvider>> getWatchProviders(String region) async {
    final response = await dio.get("/watch/providers/movie", queryParameters: {
      'watch_region': region,
    });

    return (response.data['results'] as List)
        .map((provider) => WatchProvider(
              id: provider['provider_id'],
              name: provider['provider_name'],
              logoPath: provider['logo_path'],
            ))
        .toList();
  }
}
