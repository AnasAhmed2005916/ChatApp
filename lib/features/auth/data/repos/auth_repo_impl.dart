import 'package:chat_app/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<void> login({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
