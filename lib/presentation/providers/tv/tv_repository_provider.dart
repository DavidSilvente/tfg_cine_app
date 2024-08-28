import 'package:cine_tfg_app/infrastructure/datasources/tv_moviedb_datasource.dart';
import 'package:cine_tfg_app/infrastructure/repositories/tv_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvRepositoryProvider = Provider((ref) {
  return TvRepositoryImpl(TvMoviedbDatasource());
});