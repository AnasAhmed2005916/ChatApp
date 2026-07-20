import 'package:chat_app/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthException(e));
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthException(e));
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthException(e));
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}

String _handleFirebaseAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'Please enter a valid email address.';

    case 'invalid-credential':
      return 'Invalid email or password.';

    case 'email-already-in-use':
      return 'This email is already registered.';

    case 'weak-password':
      return 'Password is too weak.';

    case 'user-disabled':
      return 'This account has been disabled.';

    case 'too-many-requests':
      return 'Too many requests. Please try again later.';

    case 'network-request-failed':
      return 'Please check your internet connection.';

    default:
      return 'Something went wrong. Please try again.';
  }
}
