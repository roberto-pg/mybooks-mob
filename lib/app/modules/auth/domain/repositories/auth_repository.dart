import 'package:my_books/app/modules/auth/external/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> userAuthentication(params);
}
