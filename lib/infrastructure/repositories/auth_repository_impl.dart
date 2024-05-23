
import 'package:tasks_app/domain/domain.dart';
import '../infrastructure.dart';


class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String correo, String password) {
    return dataSource.login(correo, password);
  }

  @override
  Future<User> register(String correo, String password, String fullName) {
    return dataSource.register(correo, password, fullName);
  }

}