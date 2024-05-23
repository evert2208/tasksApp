
import 'package:tasks_app/domain/domain.dart';



class UserMapper {


  static User userJsonToEntity( Map<String,dynamic> json ) {

     Usuario usuario = Usuario(
      id: json['user']['_id'],
      correo: json['user']['correo'],
      nombre: json['user']['nombre'],
      cel: json['user']['cel'],
      activo: json['user']['activo'],
    );
    return User(
      user: usuario,
      role: json['role'],
      token: json['token'] ?? '',
    );
  }
    

}

