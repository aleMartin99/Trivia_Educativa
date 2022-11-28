class User {
  late String id;
  late String name;
  late String username;
  late String password;
  late String email;
  late String rol;
  late String ci;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.rol,
    required this.ci,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    rol = json['rol'];
    ci = json['CI'];
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
    return data;
  }
}
