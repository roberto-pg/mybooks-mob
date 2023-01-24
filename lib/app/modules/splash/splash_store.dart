import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_books/shared/alerts/alert_factory.dart';
import 'package:my_books/shared/errors/exceptions.dart';
import 'package:my_books/shared/utils/verify_connectivity.dart';

class SplashStore extends StreamStore<BookException, String> {
  final FlutterSecureStorage _storage;
  SplashStore({required FlutterSecureStorage storage})
      : _storage = storage,
        super('');

  countdownSplash(BuildContext context) async {
    try {
      bool isTokenExpired = true;
      var token = await _storage.read(key: 'jwt');
      if (token != null) isTokenExpired = JwtDecoder.isExpired(token);
      var connectivityResult = await verifyConnectivity();
      String? logged = await _storage.read(key: 'logged');
      if (connectivityResult == ConnectivityResult.none) {
        return Timer(const Duration(seconds: 1), () {
          alertFactory(
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
        if (logged == 'isLogged' && !isTokenExpired) {
          return Timer(const Duration(seconds: 1), () {
            Modular.to.navigate('/home/');
          });
        } else {
          return Timer(const Duration(seconds: 1), () async {
            Modular.to.navigate('/auth/');
            await _storage.delete(key: 'logged');
          });
        }
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }
}
