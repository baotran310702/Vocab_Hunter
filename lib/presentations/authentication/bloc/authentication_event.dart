part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class Register extends AuthenticationEvent {
  final String email;
  final String password;
  final String userName;

  Register({
    required this.email,
    required this.password,
    required this.userName,
  });
}

class AuthWithToken extends AuthenticationEvent {}

class Logout extends AuthenticationEvent {}
