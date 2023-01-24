import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';

class GetBooksRead {
  final IBookRepository _bookRepository;

  GetBooksRead({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<List<BookModel>> call(bool read) async =>
      await _bookRepository.getBooksRead(read);
}
