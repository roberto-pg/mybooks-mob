import 'package:dio/dio.dart';
import 'package:my_books/app/modules/auth/external/user_model.dart';
import 'package:my_books/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:my_books/shared/dio/custom_dio.dart';
import 'package:my_books/shared/errors/exceptions.dart';

class AuthDatasourceImpl implements IAuthDatasource {
  final CustomDio _customDio;

  AuthDatasourceImpl({required CustomDio customDio}) : _customDio = customDio;

  @override
  Future<UserModel> login(Map<String, dynamic> params) async {
    try {
      var response = await _customDio.post('/authenticate', data: params);
      return UserModel.fromJson(response.data['user']);
    } on DioError catch (e) {
      if (e.type.toString() == 'DioErrorType.other') {
        throw const BookException('Problema inesperado no servidor');
      } else {
        throw BookException(e.response?.data['Error']);
      }
    }
  }
}
