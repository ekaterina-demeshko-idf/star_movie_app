import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/repository/remote_db_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/const.dart';

class FirestoreRepositoryImpl implements RemoteDBRepository {
  final FirebaseFirestore _firestore;
  final SharedPreferences _preferences;

  FirestoreRepositoryImpl(this._firestore, this._preferences);

  @override
  Future<bool> checkUserExist(UserModel user) async {
    final collectionRef = _firestore.collection(Config.userFirestoreCollection);

    final document = await collectionRef
        .where(
          'email',
          isEqualTo: user.email,
        )
        .where(
          'password',
          isEqualTo: user.password,
        )
        .get();

    final bool hasData = document?.docs?.isNotEmpty == true;

    if (hasData) {
      await _preferences.setString(
        'email',
        user.email,
      );
      await _preferences.setString(
        'password',
        user.password,
      );
    }

    return hasData;
  }
}
