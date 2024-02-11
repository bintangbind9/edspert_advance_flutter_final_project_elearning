import '../repositories/auth_repository.dart';
import 'usecase.dart';

class GetCurrentSignedInUseEmailUsecase implements UseCase<String?, void> {
  final AuthRepository repository;

  GetCurrentSignedInUseEmailUsecase({required this.repository});

  @override
  String? call(void params) {
    return repository.getCurrentSignedInUserEmail();
  }
}
