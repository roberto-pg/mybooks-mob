import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_books/app/modules/auth/domain/usecases/user_auth.dart';

import 'external/auth_datasource.impl.dart';
import 'infra/repositories/auth_repository_impl.dart';
import 'presenter/auth_page.dart';
import 'presenter/auth_store.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => AuthStore(userAuth: i())),
    Bind.lazySingleton((i) => UserAuth(authRepository: i(), storage: i())),
    Bind.lazySingleton(
        (i) => AuthRepositoryImpl(authDatasource: i(), storage: i())),
    Bind.lazySingleton((i) => AuthDatasourceImpl(customDio: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const AuthPage())
  ];
}
