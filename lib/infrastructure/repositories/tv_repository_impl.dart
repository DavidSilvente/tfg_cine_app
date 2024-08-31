

import 'package:cine_tfg_app/domain/datasources/tv_datasource.dart';
import 'package:cine_tfg_app/domain/entities/tv.dart';
import 'package:cine_tfg_app/domain/repositories/tv_repository.dart';

class TvRepositoryImpl extends TvRepository{

  final TvDatasource tvDatasource;

  TvRepositoryImpl(this.tvDatasource);

  @override
  Future<List<Tv>> getAiringToday({int page = 1}) {
    return tvDatasource.getAiringToday(page: page);
  }

  @override
  Future<List<Tv>> getOnTheAir({int page = 1}) {
    return tvDatasource.getOnTheAir(page: page);
  }

  @override
  Future<List<Tv>> getPopular({int page = 1}) {
    return tvDatasource.getPopular(page: page);
  }

  @override
  Future<List<Tv>> getTopRated({int page = 1}) {
    return tvDatasource.getTopRated(page: page);
  }
  
  @override
  Future<List<Tv>> serieFinDeSemana({int page = 1}) {
    return tvDatasource.serieFinDeSemana(page: page);
  }

  @override
  Future<Tv> getTvById(String id) {
    return tvDatasource.getTvById(id);
  }

}