import 'package:dio/dio.dart';
import 'package:my_books/app/modules/home/infra/datasource/total_book_datasource.dart';
import 'package:my_books/shared/dio/custom_dio_auth.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class TotalBookDatasourceImpl implements ITotalBookDatasource {
  final CustomDioAuth _customDioAuth;

  TotalBookDatasourceImpl({required CustomDioAuth customDioAuth})
      : _customDioAuth = customDioAuth;

  @override
  Future<String?> getBooksByRead(String read) async {
    try {
      final response = await _customDioAuth.get<List>('/books/read/$read');
      var bookCollection = response.headers['x-total-count']?[0].toString();
      return bookCollection;
    } on DioError catch (e) {
      throw BookException(e.response?.data['Error']);
    }
  }
}
