part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState{}

class LogedIn extends AuthState{
  final jwt;

  LogedIn(this.jwt);

  
}


class Registered extends AuthState{
 final jwt;

  Registered(this.jwt);
  
}


class ErrorHappened extends AuthState{
  final String message;

  ErrorHappened(this.message);
}


class Authorized extends AuthState{
  final String name;
  final String email;

  Authorized(this.name, this.email);
  
}

class UnAuthorized extends AuthState{
  final message ='You are not Authorized';

}