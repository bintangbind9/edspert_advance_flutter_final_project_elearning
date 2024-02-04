import '../entities/response_model.dart';
import '../entities/user_model/user_model.dart';
import '../entities/user_model/user_registration_req.dart';

abstract class UserRepository {
  Future<ResponseModel<UserModel?>?> registerUser(
      {required UserRegistrationReq req});

  Future<ResponseModel<UserModel?>?> getUserByEmail({required String email});
}
