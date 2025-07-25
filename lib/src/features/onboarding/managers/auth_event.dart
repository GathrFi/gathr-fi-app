part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.initialize() = _Initialize;
  const factory AuthEvent.loginWithEmail(String email) = _LoginWithEmail;
  const factory AuthEvent.loginWithGoogle() = _LoginWithGoogle;
  const factory AuthEvent.loginWithApple() = _LoginWithApple;
  const factory AuthEvent.loginWithDiscord() = _LoginWithDiscord;
  const factory AuthEvent.logout() = _Logout;
}
