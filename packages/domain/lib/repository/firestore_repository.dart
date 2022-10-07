import 'package:domain/model/user/user_model.dart';

abstract class FirestoreRepository {
  Future<bool> checkUserExist(UserModel user);
}
