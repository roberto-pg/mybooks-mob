import 'package:my_books/app/modules/home/domain/repositories/total_book_repository.dart';
import 'package:my_books/app/modules/home/infra/datasource/total_book_datasource.dart';

class TotalBookRepositoryImpl implements ITotalBooksRepository {
  final ITotalBookDatasource _totalBookDatasource;

  TotalBookRepositoryImpl({required ITotalBookDatasource totalBookDatasource})
      : _totalBookDatasource = totalBookDatasource;

  @override
  Future<String?> getTotalBooksByRead(read) async =>
      await _totalBookDatasource.getBooksByRead(read);
}
