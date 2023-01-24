import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_books/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:my_books/app/modules/auth/external/user_model.dart';
import 'package:my_books/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthDatasource _authDatasource;
  final FlutterSecureStorage _storage;

  AuthRepositoryImpl({
    required IAuthDatasource authDatasource,
    required FlutterSecureStorage storage,
  })  : _authDatasource = authDatasource,
        _storage = storage;

  @override
  Future<UserModel> userAuthentication(params) async {
    var response = await _authDatasource.login(params);
    await _storage.write(key: 'logged', value: 'isLogged');
    await _storage.write(key: 'userName', value: response.name);
    await _storage.write(key: 'jwt', value: response.token);
    return response;
  }
}
