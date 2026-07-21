import 'package:chat_app/features/auth/data/repos/auth_repo.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());
    try {
      await authRepo.register(name: name, email: email, password: password);
      await authRepo.sendEmailVerification();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await authRepo.login(email: email, password: password);
      final verified = await authRepo.isEmailVerified();
      if (!verified) {
        await authRepo.logout();
        emit(AuthFailure('Please verify your email first.'));
        return;
      }
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await authRepo.forgotPassword(email: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> sendEmailVerification() async {
    emit(AuthLoading());
    try {
      await authRepo.sendEmailVerification();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<bool> isEmailVerified() async {
    return await authRepo.isEmailVerified();
  }

  Future<void> checkAuthStatus() async {
    final user = authRepo.getCurrentUser();
    if (user == null) {
      emit(AuthLoggedOut());
      return;
    }
    final verified = await authRepo.isEmailVerified();
    if (verified) {
      emit(AuthAuthenticated());
    } else {
      emit(EmailNotVerified());
    }
  }
}
