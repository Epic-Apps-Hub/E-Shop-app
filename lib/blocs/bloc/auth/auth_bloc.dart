import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/repos/auth/authRepo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepo authenticationRepo;
  AuthBloc(this.authenticationRepo) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AttempLogin) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      yield AuthLoading();
      var body = await authenticationRepo.login(event.email, event.password);
      print(body.runtimeType);
      print(body);
      if (body.runtimeType == String) {
        yield ErrorHappened(body);
      } else {
        yield LogedIn(body['token']);
        prefs.setString("jwt", body['token']);
      }
    } else if (event is AttempSignup) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      yield AuthLoading();
      var body = await authenticationRepo.signup(
          event.name, event.email, event.password);

      if (body.runtimeType == String) {
        yield ErrorHappened(body);
      } else {
        yield Registered(body['token']);
        prefs.setString("jwt", body['token']);
      }
    } else if (event is CheckAuth) {
      if (event.jwt == null) {
        yield UnAuthorized();
      } else {
        yield AuthLoading();

        var body = await authenticationRepo.checkAuth(event.jwt);
        if (body['success'] == true) {
          yield Authorized(body['data']['name'], body['data']['email']);
        } else if (body.runtimeType == String) {
          yield UnAuthorized();
        }
      }
    }
  }
}
