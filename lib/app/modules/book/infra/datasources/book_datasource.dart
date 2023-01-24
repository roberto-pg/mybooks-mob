import 'package:my_books/app/modules/book/external/book_model.dart';

abstract class IBookDatasource {
  Future<void> addBook(params);
  Future<List<BookModel>> getAllBooks();
  Future<List<BookModel>> getBooksRead(bool read);
  Future<BookModel> getBookById(String id);
  Future<void> changeBookStatus(String id, String read);
  Future<void> deleteBook(String id);
}
