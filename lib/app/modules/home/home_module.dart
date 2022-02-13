import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_total_books_by_read.dart';
import 'external/total_book_datasource_impl.dart';
import 'infra/repositories/total_book_repository_impl.dart';
import 'presenter/home_page.dart';
import 'presenter/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(storage: i(), getTotalBooksByRead: i())),
    Bind.lazySingleton((i) => GetTotalBooksByRead(totalBooksRepository: i())),
    Bind.lazySingleton(
        (i) => TotalBookRepositoryImpl(totalBookDatasource: i())),
    Bind.factory((i) => TotalBookDatasourceImpl(customDioAuth: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const HomePage())
  ];
}
