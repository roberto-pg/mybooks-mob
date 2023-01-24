import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class User extends Equatable {
  final String? id;
  final String? name;
  final String email;
  final String password;
  final String? token;

  const User({
    this.id,
    this.name,
    required this.email,
    required this.password,
    this.token,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        token,
      ];

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}
