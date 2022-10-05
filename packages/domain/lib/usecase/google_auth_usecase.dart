import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';

import '../repository/auth_repository.dart';
import '../repository/firestore_repository.dart';

class GoogleAuthUseCase implements UseCase<Future<Map<String, dynamic>>> {
  final AuthRepository _authService;
  final FirestoreRepository _firestoreRepository;

  GoogleAuthUseCase(this._authService, this._firestoreRepository);

  @override
  Future<Map<String, dynamic>> call() async {
    final UserModel? user = await _authService.authWithGoogle();
    const String collectionName = 'users';
    final Map<String, dynamic>? userMap = user?.toJson();
    final bool isSuccess = await _firestoreRepository.checkUser(
      collectionName,
      userMap,
    );
    return {
      'isSuccess': isSuccess,
      'email': user?.email,
      'password': user?.password,
    };
  }
}
