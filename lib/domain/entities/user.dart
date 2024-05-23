


class User {

  final Usuario user;
  final String role;
  final String token;

  User({
    required this.user,
    required this.role,
    required this.token
  });

  bool get isAdmin {
    return role.contains('ADMIN_ROLE');
  }

}

 class Usuario {
  final String id;
  final String correo;
  final String nombre;
  final String cel;
  final bool activo;

  Usuario({
    required this.id,
    required this.correo,
    required this.nombre,
    required this.cel,
    required this.activo,
  });
 }
