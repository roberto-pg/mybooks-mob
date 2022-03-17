import 'package:dio/dio.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';
import 'package:my_books/app/modules/book/infra/datasources/book_datasource.dart';
import 'package:my_books/shared/dio/custom_dio_auth.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class BookDatasourceImpl implements IBookDatasource {
  final CustomDioAuth _customDioAuth;

  BookDatasourceImpl({required CustomDioAuth customDioAuth})
      : _customDioAuth = customDioAuth;

  @override
  Future<void> addBook(params) async {
    try {
      await _customDioAuth.post('/books', data: params);
    } on DioError catch (e) {
      if (e.type.toString() == 'DioErrorType.other') {
        throw const BookException('Problema inesperado no servidor');
      } else {
        throw BookException(e.response?.data['Error']);
      }
    }
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    try {
      var response = await _customDioAuth.get<List>('/books');
      List<BookModel> books =
          response.data!.map((e) => BookModel.fromJson(e)).toList();
      return books;
    } on DioError catch (e) {
      throw BookException(e.response?.data['Error']);
    }
  }

  @override
  Future<List<BookModel>> getBooksRead(bool read) async {
    try {
      var response = await _customDioAuth.get<List>('/books/read/$read');
      List<BookModel> books =
          response.data!.map((e) => BookModel.fromJson(e)).toList();
      return books;
    } on DioError catch (e) {
      throw BookException(e.response?.data['Error']);
    }
  }

  @override
  Future<BookModel> getBookById(String id) async {
    try {
      var response = await _customDioAuth.get('/books/$id');
      return BookModel.fromJson(response.data);
    } on DioError catch (e) {
      throw BookException(e.response?.data["Error"]);
    }
  }

  @override
  Future<void> changeBookStatus(String id, String read) async {
    try {
      await _customDioAuth.patch('/books/$id', data: {"read": read});
    } on DioError catch (e) {
      throw BookException(e.response?.data["Error"]);
    }
  }

  @override
  Future<void> deleteBook(String id) async {
    try {
      await _customDioAuth.delete('/books/$id');
    } on DioError catch (e) {
      throw BookException(e.response?.data["Error"]);
    }
  }
}
