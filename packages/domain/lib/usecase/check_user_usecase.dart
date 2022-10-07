import 'package:domain/repository/firestore_repository.dart';
import 'package:domain/usecase/usecase.dart';
import '../model/user/user_model.dart';

class CheckUserUseCase implements UseCaseParams<UserModel, Future<bool>> {
  final FirestoreRepository _firestoreRepository;

  CheckUserUseCase(this._firestoreRepository);

  @override
  Future<bool> call(UserModel user) async =>
      await _firestoreRepository.checkUserExist(user);
}
