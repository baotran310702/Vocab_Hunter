part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? success;

  const AuthenticationState({
    this.isLoading = false,
    this.error,
    this.success,
  });

  factory AuthenticationState.initial() {
    return const AuthenticationState();
  }

  AuthenticationState copyWith({
    bool? isLoading,
    String? error,
    String? success,
  }) {
    return AuthenticationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
    );
  }

  @override
  List<Object> get props => [isLoading];
}

// class AuthenticationSuccess extends AuthenticationState {
//   @override
//   final String success;
//   const AuthenticationSuccess(this.success) : super(success: success);
// }

// class AuthenticationFailure extends AuthenticationState {
//   @override
//   final String error;

//   const AuthenticationFailure(this.error) : super(error: error);

//   @override
//   List<Object> get props => [error];
// }
