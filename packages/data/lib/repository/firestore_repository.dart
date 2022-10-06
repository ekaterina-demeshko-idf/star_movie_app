import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/repository/firestore_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  final  FirebaseFirestore _firestore;
  final SharedPreferences _preferences;

  FirestoreRepositoryImpl(this._firestore, this._preferences);
  @override
  Future<bool> checkUser(
    String collection,
    Map<String, dynamic>? queryMap,
  ) async {
    final collectionRef = _firestore.collection(collection);
    Query<Map<String, dynamic>>? query;
    queryMap?.forEach((key, value) {
      query = query == null
          ? collectionRef.where(
              key,
              isEqualTo: value,
            )
          : query?.where(
              key,
              isEqualTo: value,
            );
    });

    final QuerySnapshot<Map<String, dynamic>>? document = await query?.get();
    final bool hasData = document == null ? false : document.docs.isNotEmpty;
    if (hasData) {
      await _preferences.setString(
        'email',
        queryMap?['email'],
      );
      await _preferences.setString(
        'password',
        queryMap?['password'],
      );
    }
    return hasData;
  }
}
