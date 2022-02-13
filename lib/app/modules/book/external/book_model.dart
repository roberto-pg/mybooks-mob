import 'package:my_books/app/modules/book/domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    String? id,
    required String title,
    required String author,
    required String nationality,
    required String imageurl,
    required int year,
    required bool read,
  }) : super(
          id: id,
          title: title,
          author: author,
          nationality: nationality,
          imageurl: imageurl,
          year: year,
          read: read,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        nationality: json['nationality'],
        imageurl: json['imageurl'],
        year: json['year'],
        read: json['read'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'nationality': nationality,
        'imageurl': imageurl,
        'year': year,
        'read': read,
      };
}
