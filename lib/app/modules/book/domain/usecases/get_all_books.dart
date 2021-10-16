import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';

class GetAllBooks {
  final IBookRepository _bookRepository;

  GetAllBooks({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<List<BookModel>> call() async => await _bookRepository.getAllBooks();
}
