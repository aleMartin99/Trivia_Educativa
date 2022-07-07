class User {
  String? id;
  String? nombreUsuario;
  String? contrasena;
  String? email;
  String? rol;
  String? imagen;

  User(
      {this.id,
      this.nombreUsuario,
      this.contrasena,
      this.email,
      this.rol,
      this.imagen});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreUsuario = json['nombreUsuario'];
    contrasena = json['contrasena'];
    email = json['email'];
    rol = json['rol'];
    imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombreUsuario'] = nombreUsuario;
    data['contrasena'] = contrasena;
    data['email'] = email;
    data['rol'] = rol;
    data['imagen'] = imagen;
    return data;
  }
}
// class UserModel {
//   final String name;
//   final String photoUrl;
//   final int score;

//   UserModel({
//     this.name = 'Ale',
//     this.photoUrl = "assets/images/calcifer.png",
//     this.score = 50,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'photoUrl': photoUrl,
//       'score': score,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       name: map['name'],
//       photoUrl: map['photoUrl'],
//       score: map['score'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source));
// }


