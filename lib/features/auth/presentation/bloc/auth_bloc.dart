import 'dart:ffi';

import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;

  AuthBloc({required SignupUsecase signupUsecase})
      : _signupUsecase = signupUsecase,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _signupUsecase(SignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ));

      res.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(r)));
    });
  }
}
