

class Task {

 final String id;
    final String titulo;
    final String descripcion;
    final bool estado;
    final String user;
    final String userCreate;
    final DateTime fechaInicio;
    final DateTime? fechaFin;
    final String direccion;
    final String? comentarios;
    final List<String>? evidencia;
    

  Task({
        required this.id,
        required this.titulo,
        required this.descripcion,
        required this.estado,
        required this.user,
        required this.userCreate,
        required this.fechaInicio,
        this.fechaFin,
        required this.direccion,
        this.comentarios,
        this.evidencia,
        
    });
}

class Tasks {

 final String id;
    final String titulo;
    final String descripcion;
    final bool estado;
    final User user;
    final String userCreate;
    final DateTime fechaInicio;
    final DateTime? fechaFin;
    final String direccion;
    final String? comentarios;
    final List<String>? evidencia;
    

  Tasks({
        required this.id,
        required this.titulo,
        required this.descripcion,
        required this.estado,
        required this.user,
        required this.userCreate,
        required this.fechaInicio,
        this.fechaFin,
        required this.direccion,
        this.comentarios,
        this.evidencia,
        
    });
}

class User {
    final String id;
    final String correo;
    final String nombre;

    User({
        required this.id,
        required this.correo,
        required this.nombre,
    });
}

class UserCreate {
    final String id;
    final String correo;
    final String nombre;

    UserCreate({
        required this.id,
        required this.correo,
        required this.nombre,
    });
}