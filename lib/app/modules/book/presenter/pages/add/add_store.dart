import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_books/app/modules/book/domain/usecases/add_book.dart';
import 'package:my_books/shared/alerts/dialog_factory.dart';

class AddStore {
  final AddBook _addBook;

  AddStore({required AddBook addBook}) : _addBook = addBook;

  Future<void> addBook(params) async {
    try {
      await _addBook.call(params);
      Modular.to.navigate('/home/');
    } on Exception catch (e) {
      print(e);
      dialogFactory(
        'Falha na conexão',
        'Verifique sua conexão com a internet e tente novamente',
        'OK',
        '',
        () => {},
      );
    }
  }
}
