import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../firebase/firebase_service.dart';

enum AuthProvider {
  google,
  facebook,
  apple,
  email,
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseService firebaseService;

  AuthRepositoryImpl({required this.firebaseService});

  @override
  Future<User?> signInWithGoogle() async {
    return await firebaseService.signInWithGoogle();
  }
}
