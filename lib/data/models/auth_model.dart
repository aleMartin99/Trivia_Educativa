import 'models.dart';

class Auth {
  late User user;
  late String token;

  Auth({
    required this.token,
    required this.user,
  });

  Auth.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    user = User.fromJson(json['user']);
  }
}
