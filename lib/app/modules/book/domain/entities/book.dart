import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Book extends Equatable {
  final String? id;
  final String title;
  final String author;
  final String nationality;
  final String imageurl;
  final int year;
  final bool read;

  const Book({
    this.id,
    required this.title,
    required this.author,
    required this.nationality,
    required this.imageurl,
    required this.year,
    required this.read,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        nationality,
        imageurl,
        year,
        read,
      ];

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? nationality,
    String? imageurl,
    int? year,
    bool? read,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      nationality: nationality ?? this.nationality,
      imageurl: imageurl ?? this.imageurl,
      year: year ?? this.year,
      read: read ?? this.read,
    );
  }
}
