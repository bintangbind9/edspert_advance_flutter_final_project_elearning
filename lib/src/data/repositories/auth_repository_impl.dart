import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/response_model.dart';
import '../../domain/entities/user_model/user_model.dart';
import '../../domain/entities/user_model/user_model_req.dart';
import '../../domain/repositories/auth_repository.dart';
import '../firebase/firebase_service.dart';
import '../network/api_elearning.dart';

enum AuthProvider {
  google,
  facebook,
  apple,
  email,
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseService firebaseService;
  final ApiElearning apiElearning;

  AuthRepositoryImpl({
    required this.firebaseService,
    required this.apiElearning,
  });

  @override
  Future<User?> signInWithGoogle() async {
    return await firebaseService.signInWithGoogle();
  }

  @override
  String? getCurrentSignedInUserEmail() {
    return firebaseService.getCurrentSignedInUserEmail();
  }

  @override
  bool isUserSignedIn() {
    return firebaseService.isUserSignedIn();
  }

  @override
  Future<bool> signOut() async {
    return await firebaseService.signOut();
  }

  @override
  Future<ResponseModel<UserModel?>?> getUserByEmail({
    required String email,
  }) async {
    return await apiElearning.getUserByEmail(email: email);
  }

  @override
  Future<ResponseModel<UserModel?>?> registerUser({
    required UserModelReq req,
  }) async {
    return await apiElearning.registerUser(req: req);
  }

  @override
  Future<ResponseModel<UserModel?>?> updateUser({
    required UserModelReq req,
  }) async {
    return await apiElearning.updateUser(req: req);
  }
}
