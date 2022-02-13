import 'package:my_books/app/modules/home/domain/entities/total_book.dart';

class TotalBookModel extends TotalBook {
  const TotalBookModel({
    required String name,
    required String allBooks,
    required String readBooks,
    required String unreadBooks,
  }) : super(
          name: name,
          allBooks: allBooks,
          readBooks: readBooks,
          unreadBooks: unreadBooks,
        );

  factory TotalBookModel.fromJson(Map<String, dynamic> json) => TotalBookModel(
        name: json['name'],
        allBooks: json['allBooks'],
        readBooks: json['readBooks'],
        unreadBooks: json['unreadBooks'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'allBooks': allBooks,
        'readBooks': readBooks,
        'unreadBooks': unreadBooks,
      };
}
