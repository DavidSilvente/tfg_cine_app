import 'package:cine_tfg_app/infrastructure/datasources/person_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_tfg_app/infrastructure/repositories/person_repository_impl.dart';

final personRepositoryProvider = Provider((ref) {
  return PersonRepositoryImpl(PersonDatasource());
});
