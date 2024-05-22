part of 'authentication_bloc.dart';

enum AuthStatus {
  invalidToken,
  invalidUser,
  invalidPassword,
  validToken,
  validUser,
  validPassword
}

class AuthenticationState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? success;
  final AuthStatus? authStatus;

  const AuthenticationState({
    this.isLoading = false,
    this.error,
    this.success,
    this.authStatus,
  });

  factory AuthenticationState.initial() {
    return const AuthenticationState();
  }

  AuthenticationState copyWith({
    bool? isLoading,
    String? error,
    String? success,
    AuthStatus? authStatus,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
      authStatus: authStatus,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
      ];
}
