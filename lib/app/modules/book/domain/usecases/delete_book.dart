import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';

class DeleteBook {
  final IBookRepository _bookRepository;

  DeleteBook({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<void> call(String id) => _bookRepository.deleteBook(id);
}
