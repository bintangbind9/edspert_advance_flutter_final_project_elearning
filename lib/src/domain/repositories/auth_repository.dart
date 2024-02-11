import 'package:firebase_auth/firebase_auth.dart';

import '../entities/response_model.dart';
import '../entities/user_model/user_model.dart';
import '../entities/user_model/user_model_req.dart';

abstract class AuthRepository {
  Future<User?> signInWithGoogle();

  Future<bool> signOut();

  String? getCurrentSignedInUserEmail();

  bool isUserSignedIn();

  Future<ResponseModel<UserModel?>?> registerUser({
    required UserModelReq req,
  });

  Future<ResponseModel<UserModel?>?> getUserByEmail({required String email});

  Future<ResponseModel<UserModel?>?> updateUser({required UserModelReq req});
}
