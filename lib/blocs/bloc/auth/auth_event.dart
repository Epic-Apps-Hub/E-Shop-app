part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AttempLogin extends AuthEvent {
  final String email;
  final String password;

  AttempLogin(this.email, this.password);
}

class AttempSignup extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AttempSignup(this.email, this.password, this.name);
}

class CheckAuth extends AuthEvent {
  final String jwt;

  CheckAuth(this.jwt);
}
