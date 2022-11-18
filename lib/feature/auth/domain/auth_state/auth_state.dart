part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.notAuthorized() = _AuthStateNotAuthorized;
  factory AuthState.authorized(UserEntity userEntity) = _AuthStateAuthorized;
  factory AuthState.waiting() = _AuthStateWaiting;
  factory AuthState.error(String error) = _AuthStateError;
}
