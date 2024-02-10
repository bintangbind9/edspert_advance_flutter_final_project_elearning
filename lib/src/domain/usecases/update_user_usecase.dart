import '../entities/response_model.dart';
import '../entities/user_model/user_model.dart';
import '../entities/user_model/user_model_req.dart';
import '../repositories/auth_repository.dart';
import 'usecase.dart';

class UpdateUserUsecase
    implements UseCase<Future<ResponseModel<UserModel?>?>, UserModelReq> {
  final AuthRepository repository;

  UpdateUserUsecase({required this.repository});

  @override
  Future<ResponseModel<UserModel?>?> call(UserModelReq params) async {
    return await repository.updateUser(req: params);
  }
}
