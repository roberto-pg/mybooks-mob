import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';

class GetBookById {
  final IBookRepository _bookRepository;

  GetBookById({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<BookModel> call(String id) => _bookRepository.getBookById(id);
}
