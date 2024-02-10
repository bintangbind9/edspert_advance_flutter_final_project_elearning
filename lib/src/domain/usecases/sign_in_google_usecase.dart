import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/auth_repository.dart';
import 'usecase.dart';

class SignInWithGoogleUsecase implements UseCase<Future<User?>, void> {
  final AuthRepository repository;

  SignInWithGoogleUsecase({required this.repository});

  @override
  Future<User?> call(void params) async {
    return await repository.signInWithGoogle();
  }
}
