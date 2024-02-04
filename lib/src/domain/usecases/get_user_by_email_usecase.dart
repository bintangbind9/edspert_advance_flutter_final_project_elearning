import '../entities/response_model.dart';
import '../entities/user_model/user_model.dart';
import '../repositories/user_repository.dart';
import 'usecase.dart';

class GetUserByEmailUsecase
    implements UseCase<ResponseModel<UserModel?>?, String> {
  final UserRepository repository;

  GetUserByEmailUsecase({required this.repository});

  @override
  Future<ResponseModel<UserModel?>?> call(String email) async {
    return await repository.getUserByEmail(email: email);
  }
}
