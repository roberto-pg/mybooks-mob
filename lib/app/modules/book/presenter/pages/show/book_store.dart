import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_books/app/modules/book/domain/usecases/get_all_books.dart';
import 'package:my_books/app/modules/book/domain/usecases/get_books_read.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class BookStore extends NotifierStore<Exception, List<BookModel>> {
  final GetAllBooks _getAllBooks;
  final GetBooksRead _getBooksRead;

  BookStore(
      {required GetAllBooks getAllBooks, required GetBooksRead getBooksRead})
      : _getAllBooks = getAllBooks,
        _getBooksRead = getBooksRead,
        super([]);

  Future<void> getBooks() async {
    try {
      setLoading(true);
      var response = await _getAllBooks.call();
      update(response);
      setLoading(false);
    } catch (e) {
      setError(BookException(e.toString()), force: true);
    }
  }

  Future<void> getBooksRead(bool read) async {
    try {
      setLoading(true);
      var response = await _getBooksRead.call(read);
      update(response);
      setLoading(false);
    } catch (e) {
      setError(BookException(e.toString()), force: true);
    }
  }
}
