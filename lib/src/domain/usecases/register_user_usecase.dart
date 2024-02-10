import '../entities/response_model.dart';
import '../entities/user_model/user_model.dart';
import '../entities/user_model/user_model_req.dart';
import '../repositories/auth_repository.dart';
import 'usecase.dart';

class RegisterUserUsecase
    implements UseCase<Future<ResponseModel<UserModel?>?>, UserModelReq> {
  final AuthRepository repository;

  RegisterUserUsecase({required this.repository});

  @override
  Future<ResponseModel<UserModel?>?> call(UserModelReq req) async {
    return await repository.registerUser(req: req);
  }
}
