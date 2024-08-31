import 'package:cine_tfg_app/domain/entities/entities.dart';



abstract class TvDatasource {
  Future<List<Tv>> getOnTheAir({int page = 1});
  Future<List<Tv>> getAiringToday({int page = 1});
  Future<List<Tv>> getPopular({int page = 1});
  Future<List<Tv>> getTopRated({int page = 1});
  Future<List<Tv>> serieFinDeSemana({int page = 1});
  Future<Tv> getTvById(String id);
}