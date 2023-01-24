import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';

class ChangeBookStatus {
  final IBookRepository _bookRepository;

  ChangeBookStatus({required IBookRepository bookRepository})
      : _bookRepository = bookRepository;

  Future<void> call(String id, String read) =>
      _bookRepository.changeBookStatus(id, read);
}
