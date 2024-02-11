import '../repositories/auth_repository.dart';
import 'usecase.dart';

class SignOutUsecase implements UseCase<Future<bool>, void> {
  final AuthRepository repository;

  SignOutUsecase({required this.repository});

  @override
  Future<bool> call(void params) async {
    return await repository.signOut();
  }
}
