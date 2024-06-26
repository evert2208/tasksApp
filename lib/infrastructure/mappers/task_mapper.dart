
import 'package:tasks_app/domain/entities/task.dart';



class TaskMapper {


  static jsonToEntity( Map<String, dynamic> json ) => Task(
        id: json["_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        direccion: json["direccion"],
        comentarios: json['comentarios'],
        estado: json["estado"],
        user: json["user"],
        userCreate: json["userCreate"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: json["fechaFin"] != null ? DateTime.parse(json["fechaFin"]) : null,
        evidencia: json["evidencia"] != null ? List<String>.from(json["evidencia"].map((x) => x as String)) : [],
       
  );


}

class TasksMapper {


  static Tasks tasksjsonToEntity( Map<String, dynamic> json ) {
    User usuario = User(
      id: json['user']['_id'],
      correo: json['user']['correo'],
      nombre: json['user']['nombre'],
    
    );
    return Tasks(
      id: json["_id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        direccion: json["direccion"],
        comentarios: json['comentarios'],
        estado: json["estado"],
        user:usuario,
        userCreate: json["userCreate"],
        fechaInicio: DateTime.parse(json["fechaInicio"]),
        fechaFin: json["fechaFin"] != null ? DateTime.parse(json["fechaFin"]) : null,
        evidencia: json["evidencia"] != null ? List<String>.from(json["evidencia"].map((x) => x as String)) : [],
       
    );
        
  }


}
