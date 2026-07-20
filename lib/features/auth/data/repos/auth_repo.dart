import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<void> login({required String email, required String password});
  Future<void> register({required String email, required String password});

  Future<void> forgotPassword({required String email});

  Future<void> logout();

  Future<void> sendEmailVerification();
  Future<bool> isEmailVerified();

  User? getCurrentUser() {}
}
