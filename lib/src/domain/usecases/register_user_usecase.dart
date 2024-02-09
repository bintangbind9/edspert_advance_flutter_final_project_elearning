import '../entities/response_model.dart';
import '../entities/user_model/user_model.dart';
import '../entities/user_model/user_registration_req.dart';
import '../repositories/auth_repository.dart';
import 'usecase.dart';

class RegisterUserUsecase
    implements UseCase<ResponseModel<UserModel?>?, UserRegistrationReq> {
  final AuthRepository repository;

  RegisterUserUsecase({required this.repository});

  @override
  Future<ResponseModel<UserModel?>?> call(UserRegistrationReq req) async {
    return await repository.registerUser(req: req);
  }
}
