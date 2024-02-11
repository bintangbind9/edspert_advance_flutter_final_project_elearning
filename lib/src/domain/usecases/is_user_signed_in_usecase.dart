import '../repositories/auth_repository.dart';
import 'usecase.dart';

class IsUserSignedInUsecase implements UseCase<bool, void> {
  final AuthRepository repository;

  IsUserSignedInUsecase({required this.repository});

  @override
  bool call(void params) {
    return repository.isUserSignedIn();
  }
}
