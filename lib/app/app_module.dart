import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modular_triple_bind/modular_triple_bind.dart';
import 'package:my_books/app/modules/auth/auth_module.dart';
import 'package:my_books/app/modules/home/home_module.dart';
import 'package:my_books/app/modules/splash/splash_page.dart';
import 'package:my_books/shared/dio/custom_dio.dart';
import 'package:my_books/shared/dio/custom_dio_auth.dart';

import 'modules/book/book_module.dart';
import 'modules/splash/splash_store.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => const FlutterSecureStorage()),
        Bind.singleton((i) => CustomDio()),
        Bind.singleton((i) => CustomDioAuth(storage: i())),
        TripleBind.singleton((i) => SplashStore(storage: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashPage()),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/book', module: BookModule())
      ];
}
