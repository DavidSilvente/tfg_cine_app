

import 'package:cine_tfg_app/domain/datasources/local_storage_datasource.dart';
import 'package:cine_tfg_app/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalStorageDatasource{

  late Future<Isar> db;
  
  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if(Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        inspector: true,
        directory: dir.path
        );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async{
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies.filter().idEqualTo(movieId).findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async{
    final isar = await db;

    return isar.movies.where()
    .offset(offset)
    .limit(limit)
    .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async{
    final isar = await db;

    final favoriteMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();


    
    if (favoriteMovie == null) {
          isar.writeTxnSync(() => isar.movies.putSync(movie));

    } else {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
    }

    

  }

}