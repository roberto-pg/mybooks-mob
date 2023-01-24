import 'package:my_books/app/modules/book/domain/repositories/book_repository.dart';
import 'package:my_books/app/modules/book/external/book_model.dart';
import 'package:my_books/app/modules/book/infra/datasources/book_datasource.dart';

class BookRepositoryImpl implements IBookRepository {
  final IBookDatasource _bookDatasource;

  BookRepositoryImpl({required IBookDatasource bookDatasource})
      : _bookDatasource = bookDatasource;

  @override
  Future<void> addBook(params) async =>
      await _bookDatasource.addBook(params);

  @override
  Future<List<BookModel>> getAllBooks() async =>
      await _bookDatasource.getAllBooks();

  @override
  Future<List<BookModel>> getBooksRead(bool read) async =>
      await _bookDatasource.getBooksRead(read);

  @override
  Future<BookModel> getBookById(String id) => _bookDatasource.getBookById(id);

  @override
  Future<void> changeBookStatus(String id, String read) =>
      _bookDatasource.changeBookStatus(id, read);

  @override
  Future<void> deleteBook(String id) => _bookDatasource.deleteBook(id);
}
