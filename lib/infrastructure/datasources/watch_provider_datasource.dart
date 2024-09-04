// data/datasources/watch_provider_datasource_impl.dart
import 'package:cine_tfg_app/domain/datasources/watch_provider_datasource.dart';
import 'package:cine_tfg_app/domain/entities/watch_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchProviderDatasourceImpl implements WatchProviderDatasource {
  static const String _watchProviderKey = 'selected_watch_provider';
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
  
  @override
  Future<void> saveWatchProviderId(String providerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_watchProviderKey, providerId);
  }

  @override
  Future<String?> getWatchProviderId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_watchProviderKey);
  }
}
