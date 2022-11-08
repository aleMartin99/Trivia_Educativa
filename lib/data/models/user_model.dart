class User {
  String? id;
  String? name;
  String? username;
  String? password;
  String? email;
  String? rol;
  String? ci;
  //s String? token;

  //String imagen;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.rol,
    required this.ci,
    // this.imagen
  });
  // User fromJson(Map json) => User(
  //       id: json['_id'] as String?,
  //       name: json['name'] as String?,
  //       username: json['username'] as String,
  //       email: json['email'] as String?,
  //       password: json['password'] as String,
  //       rol: json['rol'] as String,
  //       ci: json['CI'] as String,
  //     );

  User.fromJson(Map<String, dynamic> json) {
    // token = ['access_token'];
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    rol = json['rol'];
    ci = json['CI'];
    // imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['rol'] = rol;
    data['CI'] = ci;
    //data['imagen'] = imagen;
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


