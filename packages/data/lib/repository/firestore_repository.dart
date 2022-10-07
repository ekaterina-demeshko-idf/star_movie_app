import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/repository/remote_db_repository.dart';
import '../utils/const.dart';

class FirestoreRepositoryImpl implements RemoteDBRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepositoryImpl(this._firestore);

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
    return hasData;
  }
}
