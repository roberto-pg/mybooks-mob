import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';

class AddBook {
  final IBookRepository _bookRepository;

  AddBook({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<void> call(params) async =>
      await _bookRepository.addBook(params);
}
