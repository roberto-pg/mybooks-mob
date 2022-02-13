import 'package:my_books/app/modules/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    String? id,
    String? name,
    required String email,
    required String password,
    String? token,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          token: token,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        token: json['token'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'token': token,
      };
}
