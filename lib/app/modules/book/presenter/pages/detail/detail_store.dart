import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_books/app/modules/book/domain/usecases/change_book_status.dart';
import 'package:my_books/app/modules/book/domain/usecases/delete_book.dart';
import 'package:my_books/app/modules/book/domain/usecases/get_book_by_id.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class DetailStore extends NotifierStore<Exception, BookModel> {
  final GetBookById _getBookById;
  final ChangeBookStatus _changeBookStatus;
  final DeleteBook _deleteBook;
  DetailStore({
    required GetBookById getBookById,
    required ChangeBookStatus changeBookStatus,
    required DeleteBook deleteBook,
  })  : _getBookById = getBookById,
        _changeBookStatus = changeBookStatus,
        _deleteBook = deleteBook,
        super(const BookModel(
            author: '',
            imageurl: '',
            nationality: '',
            read: false,
            title: '',
            year: 0));

  Future<void> getBookById(String id) async {
    try {
      setLoading(true);
      var response = await _getBookById.call(id);
      update(response);
      setLoading(false);
    } catch (e) {
      setError(BookException(e.toString()));
    }
  }

  Future<void> changeBookStatus(String id, String read) async {
    try {
      await _changeBookStatus.call(id, read);
    } catch (e) {
      throw BookException(e.toString());
    }
  }

  Future<void> deleteBook(String id) async {
    try {
      await _deleteBook.call(id);
    } catch (e) {
      throw BookException(e.toString());
    }
  }
}
