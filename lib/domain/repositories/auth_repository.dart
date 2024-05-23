
import '../entities/user.dart';

abstract class AuthRepository {

  Future<User> login( String correo, String password );
  Future<User> register( String correo, String password, String fullName );
  Future<User> checkAuthStatus( String token );

}

