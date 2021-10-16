import 'package:equatable/equatable.dart';

class BookException extends Equatable implements Exception {
  final String message;

  BookException(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [];
}
