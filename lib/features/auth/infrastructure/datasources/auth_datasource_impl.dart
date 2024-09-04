

import 'package:cine_tfg_app/config/constants/environment.dart';
import 'package:cine_tfg_app/features/auth/domain/domain.dart';
import 'package:cine_tfg_app/features/auth/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

class AuthDataSourceImpl extends AuthDataSource {

final dio = Dio(
  BaseOptions(
    baseUrl: Environment.apiUrl
  )
);

  @override
  Future<User> checkAuthStatus(String token) async{
     try {
      
      final response = await dio.get('/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          }
        )
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;


    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }

  }

  @override
  Future<User> login(String email, String password) async {
    
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
      
    } on DioException catch (e) {
      if( e.response?.statusCode == 401 ){
         throw CustomError(e.response?.data['message'] ?? 'Credenciales incorrectas' );
      }
      if ( e.type == DioExceptionType.connectionTimeout ){
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }


  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

  