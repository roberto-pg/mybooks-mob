import 'package:my_books/app/modules/auth/external/user_model.dart';

abstract class IAuthDatasource {
  Future<UserModel> login(Map<String, dynamic> params);
}
