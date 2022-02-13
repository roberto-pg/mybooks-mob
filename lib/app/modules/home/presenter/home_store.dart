import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_books/app/modules/home/domain/entities/total_book.dart';
import 'package:my_books/app/modules/home/domain/usecases/get_total_books_by_read.dart';
import 'package:my_books/app/modules/home/external/total_book_model.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class HomeStore extends NotifierStore<Exception, TotalBookModel> {
  final FlutterSecureStorage _storage;
  final GetTotalBooksByRead _getTotalBooksByRead;

  HomeStore({
    required FlutterSecureStorage storage,
    required GetTotalBooksByRead getTotalBooksByRead,
  })  : _storage = storage,
        _getTotalBooksByRead = getTotalBooksByRead,
        super(const TotalBookModel(
          name: '',
          allBooks: '',
          readBooks: '',
          unreadBooks: '',
        ));

  Future logoutUser() async {
    await _storage.delete(key: 'logged');
  }

  Future<void> getTotalBooksByRead() async {
    try {
      setLoading(true);
      TotalBook totalBook = const TotalBook(
        name: '',
        allBooks: '',
        readBooks: '',
        unreadBooks: '',
      );
      var _name = await _storage.read(key: 'userName');
      var _all = await _getTotalBooksByRead.call('all');
      var _read = await _getTotalBooksByRead.call('true');
      var _unRead = await _getTotalBooksByRead.call('false');
      totalBook = totalBook.copyWith(name: _name);
      totalBook = totalBook.copyWith(allBooks: _all);
      totalBook = totalBook.copyWith(readBooks: _read);
      totalBook = totalBook.copyWith(unreadBooks: _unRead);
      var totalsForDrawer = TotalBookModel(
          name: totalBook.name,
          allBooks: totalBook.allBooks,
          readBooks: totalBook.readBooks,
          unreadBooks: totalBook.unreadBooks);

      update(totalsForDrawer);
      setLoading(false);
    } on Exception catch (e) {
      setError(BookException(e.toString()));
    }
  }
}
