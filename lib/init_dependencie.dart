import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecse.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<SignupUsecase>(
      () => SignupUsecase(
        serviceLocator(),
      ),
    )
    ..registerFactory<LoginUsecase>(
      () => LoginUsecase(
        serviceLocator(),
      ),
    )
    ..registerFactory<CurrentUserUsecase>(
      () => CurrentUserUsecase(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        signupUsecase: serviceLocator(),
        loginUsecase: serviceLocator(),
        currentUserUsecase: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
