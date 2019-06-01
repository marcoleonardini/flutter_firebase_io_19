class User {
  final String email;
  final String uId;
  final String nombre;

  User({this.email, this.uId, this.nombre});

  Map<String, Object> toJson() {
    return {'email': email, 'uId': '', 'nombre': nombre};
  }

  factory User.fromJson(Map doc) {
    User user =
        User(email: doc['email'], uId: doc['uId'], nombre: doc['nombre']);
    return user;
  }
}
