import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredentialResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredentialResult.user;
    } catch (e) {
      debugPrint('Error signInWithGoogle $e');
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error signOut: $e, $stackTrace');
      }
      return false;
    }
  }

  String? getCurrentSignedInUserEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }

  bool isUserSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
