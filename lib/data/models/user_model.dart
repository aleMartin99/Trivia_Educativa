import 'dart:convert';

// import 'package:educational_quiz_app/core/app_images.dart';

class UserModel {
  final String name;
  final String photoUrl;
  final int score;

  UserModel({
    this.name = 'Ale',
    this.photoUrl = "assets/images/calcifer.png",
    this.score = 50,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'score': score,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      photoUrl: map['photoUrl'],
      score: map['score'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
