import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';

import '../repository/auth_repository.dart';
import '../repository/firestore_repository.dart';

class FacebookAuthUseCase implements UseCase<Future<bool>> {
  final AuthRepository _authService;
  final FirestoreRepository _firestoreRepository;
  FacebookAuthUseCase(this._authService, this._firestoreRepository);

  @override
  Future<bool> call() async {
    final UserModel? user = await _authService.authWithFacebook();
    const String collectionName = 'users';
    final Map<String, dynamic>? userMap = user?.toJson();
    return await _firestoreRepository.checkUser(
      collectionName,
      userMap,
    );
  }
}