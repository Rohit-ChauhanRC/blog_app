import 'dart:ffi';

import 'package:blog_app/features/auth/domain/usecases/login_usecse.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;
  final LoginUsecase _loginUsecase;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required SignupUsecase signupUsecase,
  })  : _signupUsecase = signupUsecase,
        _loginUsecase = loginUsecase,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _signupUsecase(SignupParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSuccess(r)));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _loginUsecase(LoginUsecaseParams(
      email: event.email,
      password: event.password,
    ));

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => emit(AuthSuccess(r)));
  }
}
