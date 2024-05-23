import '../entities/user.dart';

abstract class AuthDataSource {

  Future<User> login( String correo, String password );
  Future<User> register( String correo, String password, String fullName );
  Future<User> checkAuthStatus( String token );

}

