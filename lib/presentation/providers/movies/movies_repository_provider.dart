import 'package:cine_tfg_app/infrastructure/datasources/movidedb_datasource.dart';
import 'package:cine_tfg_app/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repositorio inmutable. Solo lectura
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDataSource());
});