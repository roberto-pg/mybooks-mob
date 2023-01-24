import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  AuthInterceptor({required FlutterSecureStorage storage}) : _storage = storage;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await _storage.read(key: 'jwt');

    if (token != null) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: ('Bearer $token'),
      });
    }

    handler.next(options);
  }
}
