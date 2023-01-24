import 'package:my_books/app/modules/home/domain/repositories/total_book_repository.dart';

class GetTotalBooksByRead {
  final ITotalBooksRepository _totalBooksRepository;

  GetTotalBooksByRead({required ITotalBooksRepository totalBooksRepository})
      : _totalBooksRepository = totalBooksRepository;

  Future<String?> call(read) async =>
      await _totalBooksRepository.getTotalBooksByRead(read);
}
