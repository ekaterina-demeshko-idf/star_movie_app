import 'package:domain/model/user/user_model.dart';

abstract class RemoteDBRepository {
  Future<bool> checkUserExist(UserModel user);
}
