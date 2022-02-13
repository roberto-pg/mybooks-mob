import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_books/shared/alerts/dialog_factory.dart';
import 'package:my_books/shared/errors/exceptions.dart';
import 'package:my_books/shared/utils/verify_connectivity.dart';

class SplashStore extends StreamStore<BookException, String> {
  final FlutterSecureStorage _storage;
  SplashStore({required FlutterSecureStorage storage})
      : _storage = storage,
        super('');

  countdownSplash(BuildContext context) async {
    try {
      var connectivityResult = await verifyConnectivity();
      String? logged = await _storage.read(key: 'logged');
      if (connectivityResult == ConnectivityResult.none) {
        return Timer(const Duration(seconds: 1), () {
          dialogFactory(
            'Falha na conexão',
            'Verifique sua conexão com a internet e tente novamente',
            'OK',
            '',
            () => exit(0),
          );
        });
      }
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        if (logged == 'isLogged') {
          return Timer(const Duration(seconds: 1), () {
            Modular.to.pushReplacementNamed('/home/');
          });
        } else {
          return Timer(const Duration(seconds: 1), () async {
            Modular.to.pushReplacementNamed('/auth/');
            await _storage.deleteAll();
          });
        }
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }
}
