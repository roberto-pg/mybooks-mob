import 'dart:developer';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_books/app/modules/auth/domain/usecases/user_auth.dart';
import 'package:my_books/app/modules/auth/external/user_model.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class AuthStore extends StreamStore<BookException, UserModel> {
  final UserAuth _userAuth;

  AuthStore({required UserAuth userAuth})
      : _userAuth = userAuth,
        super(const UserModel(
          email: '',
          password: '',
        ));

  Future<void> addLogin(params) async {
    // execute(
    //   () => _userAuth.call(params),
    // );

    // O método 'execute()' substitue o trecho de código abaixo:
    try {
      setLoading(true);
      var response = await _userAuth.call(params);
      update(response, force: true);
      setLoading(false);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      setError(BookException(e.toString()), force: true);
    }
  }
}
