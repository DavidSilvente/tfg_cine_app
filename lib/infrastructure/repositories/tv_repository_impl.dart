

import 'package:cine_tfg_app/domain/datasources/tv_datasource.dart';
import 'package:cine_tfg_app/domain/entities/tv.dart';
import 'package:cine_tfg_app/domain/repositories/tv_repository.dart';

class TvRepositoryImpl extends TvRepository{

  final TvDatasource tvDatasource;

  TvRepositoryImpl(this.tvDatasource);

  @override
  Future<List<Tv>> getAiringToday({int page = 1, String? watchProviderId,}) {
    return tvDatasource.getAiringToday(page: page, watchProviderId: watchProviderId);
  }

  @override
  Future<List<Tv>> getOnTheAir({int page = 1, String? watchProviderId,}) {
    return tvDatasource.getOnTheAir(page: page, watchProviderId: watchProviderId);
  }

  @override
  Future<List<Tv>> getPopular({int page = 1, String? watchProviderId,}) {
    return tvDatasource.getPopular(page: page, watchProviderId: watchProviderId);
  }

  @override
  Future<List<Tv>> getTopRated({int page = 1, String? watchProviderId,}) {
    return tvDatasource.getTopRated(page: page, watchProviderId: watchProviderId);
  }
  
  @override
  Future<List<Tv>> serieFinDeSemana({int page = 1, String? watchProviderId,}) {
    return tvDatasource.serieFinDeSemana(page: page, watchProviderId: watchProviderId);
  }

  @override
  Future<Tv> getTvById(String id) {
    return tvDatasource.getTvById(id);
  }

}