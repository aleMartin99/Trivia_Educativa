import 'models.dart';

class Auth {
  late User user;
  late String token;

//TODO make token global with shared preferences
  Auth({
    required this.token,
    required this.user,
    // this.imagen
  });

  Auth.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    user = User.fromJson(json['user']);
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

