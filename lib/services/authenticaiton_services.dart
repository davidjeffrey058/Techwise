import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:techwise_pub/Models/user_properties.dart';

class AuthenticationServices {
  final auth = FirebaseAuth.instance;
  String errorMessage = 'An error occured';

  UserProperties? customUserFromFirebase(User? user) {
    return user != null
        ? UserProperties(
            uid: user.uid,
            email: user.email,
            fullName: user.displayName,
            photoUrl: user.photoURL,
            emailVerified: user.emailVerified)
        : null;
  }

  Stream<UserProperties?> get authenticationState {
    return auth.authStateChanges().map(customUserFromFirebase);
  }

  //Register user with email and password
  Future registerWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final UserCredential credential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateDisplayName(fullName);
      return customUserFromFirebase(credential.user);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Check your internet connection';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    return null;
  }

  //Login user with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      return customUserFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (error.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    return null;
  }

  // Login user with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final userCredential = await auth.signInWithCredential(credential);

      return customUserFromFirebase(userCredential.user);
    } catch (error) {
      errorMessage = "Couldn't sign in";
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().isSignedIn() ? GoogleSignIn().signOut() : auth.signOut();
  }
}
