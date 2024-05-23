

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