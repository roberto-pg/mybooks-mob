import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDioAuth extends DioForNative {
  final FlutterSecureStorage _storage;
  


  static final _baseOptions = BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 20000,
  );

  CustomDioAuth({required FlutterSecureStorage storage})
      : _storage = storage,
        super(_baseOptions) {
    interceptors.addAll([
      AuthInterceptor(storage: _storage),
    ]);
  }
}
