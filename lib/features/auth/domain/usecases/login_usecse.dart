import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements Usecase<User, LoginUsecaseParams> {
  final AuthRepository repository;

  LoginUsecase(this.repository);
  @override
  Future<Either<Failures, User>> call(LoginUsecaseParams params) async {
    return await repository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginUsecaseParams {
  final String email;
  final String password;

  LoginUsecaseParams({
    required this.email,
    required this.password,
  });
}
