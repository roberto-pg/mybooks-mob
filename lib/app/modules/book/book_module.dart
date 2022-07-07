import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_triple_bind/modular_triple_bind.dart';
import 'package:my_books/app/modules/book/domain/usecases/add_book.dart';
import 'package:my_books/app/modules/book/domain/usecases/change_book_status.dart';
import 'package:my_books/app/modules/book/domain/usecases/delete_book.dart';
import 'package:my_books/app/modules/book/domain/usecases/get_all_books.dart';
import 'package:my_books/app/modules/book/domain/usecases/get_book_by_id.dart';
import 'package:my_books/app/modules/book/domain/usecases/get_books_read.dart';
import 'package:my_books/app/modules/book/external/book_datasource_impl.dart';
import 'package:my_books/app/modules/book/infra/repositories/book_repository_impl.dart';
import 'package:my_books/app/modules/book/presenter/pages/add/add_store.dart';
import 'package:my_books/app/modules/book/presenter/pages/detail/detail_page.dart';
import 'package:my_books/app/modules/book/presenter/pages/detail/detail_store.dart';

import 'presenter/pages/add/add_book_page.dart';
import 'presenter/pages/show/book_page.dart';
import 'presenter/pages/show/book_store.dart';

class BookModule extends Module {
  @override
  List<Bind> get binds => [
        TripleBind.factory(
            (i) => BookStore(getAllBooks: i(), getBooksRead: i())),
        TripleBind.factory((i) => DetailStore(
            getBookById: i(), changeBookStatus: i(), deleteBook: i())),
        Bind.factory((i) => AddStore(addBook: i())),
        Bind.lazySingleton((i) => GetAllBooks(bookRepository: i())),
        Bind.lazySingleton((i) => GetBooksRead(bookRepository: i())),
        Bind.lazySingleton((i) => GetBookById(bookRepository: i())),
        Bind.lazySingleton((i) => ChangeBookStatus(bookRepository: i())),
        Bind.lazySingleton((i) => DeleteBook(bookRepository: i())),
        Bind.lazySingleton((i) => AddBook(bookRepository: i())),
        Bind.lazySingleton((i) => BookRepositoryImpl(bookDatasource: i())),
        Bind.lazySingleton((i) => BookDatasourceImpl(customDioAuth: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => BookPage(read: args.data),
            transition: TransitionType.rightToLeft,
            duration: const Duration(seconds: 1)),
        ChildRoute('/detail',
            child: (_, args) => DetailPage(id: args.data),
            transition: TransitionType.rotate,
            duration: const Duration(seconds: 1)),
        ChildRoute('/addBook', child: (_, __) => const AddBookPage()),
      ];
}
