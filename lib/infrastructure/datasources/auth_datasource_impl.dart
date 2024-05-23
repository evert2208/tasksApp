import 'package:dio/dio.dart';
import 'package:tasks_app/config/config.dart';
import 'package:tasks_app/domain/domain.dart';
import 'package:tasks_app/infrastructure/infrastructure.dart';


class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> checkAuthStatus(String token) async {
    
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
  Future<User> login(String correo, String password) async {
    
    try {
      final response = await dio.post('/auth/login', data: {
        'correo': correo,
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
  Future<User> register(String correo, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
}
