import 'package:equatable/equatable.dart';

class BookException extends Equatable implements Exception {
  final String message;

  const BookException(this.message);

  @override
  String toString() => message;

  @override
  List<Object?> get props => [];
}
