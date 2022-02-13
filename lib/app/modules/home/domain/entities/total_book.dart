import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class TotalBook extends Equatable {
  final String name;
  final String allBooks;
  final String readBooks;
  final String unreadBooks;

  const TotalBook({
    required this.name,
    required this.allBooks,
    required this.readBooks,
    required this.unreadBooks,
  });

  @override
  List<Object> get props => [
        name,
        allBooks,
        readBooks,
        unreadBooks,
      ];

  TotalBook copyWith({
    String? name,
    String? allBooks,
    String? readBooks,
    String? unreadBooks,
  }) {
    return TotalBook(
      name: name ?? this.name,
      allBooks: allBooks ?? this.allBooks,
      readBooks: readBooks ?? this.readBooks,
      unreadBooks: unreadBooks ?? this.unreadBooks,
    );
  }
}
