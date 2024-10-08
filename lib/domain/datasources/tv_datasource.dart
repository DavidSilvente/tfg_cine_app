import 'package:cine_tfg_app/domain/entities/entities.dart';



abstract class TvDatasource {
  Future<List<Tv>> getOnTheAir({int page = 1, String? watchProviderId,});
  Future<List<Tv>> getAiringToday({int page = 1, String? watchProviderId,});
  Future<List<Tv>> getPopular({int page = 1, String? watchProviderId,});
  Future<List<Tv>> getTopRated({int page = 1, String? watchProviderId,});
  Future<List<Tv>> serieFinDeSemana({int page = 1, String? watchProviderId,});
  Future<Tv> getTvById(String id);
}