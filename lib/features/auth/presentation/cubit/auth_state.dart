sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

final class AuthLoggedOut extends AuthState {}

final class AuthAuthenticated extends AuthState {}

final class EmailNotVerified extends AuthState {}
