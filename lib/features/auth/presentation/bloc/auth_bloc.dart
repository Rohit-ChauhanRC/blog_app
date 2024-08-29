import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecse.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase _signupUsecase;
  final LoginUsecase _loginUsecase;
  final CurrentUserUsecase _currentUserUsecase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required SignupUsecase signupUsecase,
    required CurrentUserUsecase currentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _signupUsecase = signupUsecase,
        _loginUsecase = loginUsecase,
        _currentUserUsecase = currentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _signupUsecase(SignupParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSucces(r, emit));
  }

  void _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _loginUsecase(LoginUsecaseParams(
      email: event.email,
      password: event.password,
    ));

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSucces(r, emit));
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUserUsecase(NoParams());
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSucces(r, emit));
  }

  void _emitAuthSucces(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
