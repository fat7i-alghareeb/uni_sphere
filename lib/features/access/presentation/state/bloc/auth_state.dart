part of 'auth_bloc.dart';

class AuthState {
  Result<User> loginResult;
  Result<User> registerResult;
  Result<SimpleUser> checkOneTimeResult;

  AuthState({
    this.loginResult = const Result.loading(),
    this.registerResult = const Result.loading(),
    this.checkOneTimeResult = const Result.loading(),
  });

  AuthState copyWith({
    Result<User>? loginResult,
    Result<User>? registerResult,
    Result<SimpleUser>? checkOneTimeResult,
  }) {
    return AuthState(
      loginResult: loginResult ?? this.loginResult,
      registerResult: registerResult ?? this.registerResult,
      checkOneTimeResult: checkOneTimeResult ?? this.checkOneTimeResult,
    );
  }
}