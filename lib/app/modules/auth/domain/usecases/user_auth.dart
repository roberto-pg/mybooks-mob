import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_books/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:my_books/app/modules/auth/external/user_model.dart';

class UserAuth {
  final IAuthRepository _authRepository;

  UserAuth(
      {required IAuthRepository authRepository,
      required FlutterSecureStorage storage})
      : _authRepository = authRepository;

  Future<UserModel> call(params) async {
    var response = await _authRepository.userAuthentication(params);
    return response;
  }
}
