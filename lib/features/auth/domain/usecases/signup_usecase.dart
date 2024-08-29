import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignupUsecase implements Usecase<User, SignupParams> {
  final AuthRepository repository;

  SignupUsecase(this.repository);
  @override
  Future<Either<Failures, User>> call(SignupParams params) async {
    return await repository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class SignupParams {
  final String name;
  final String email;
  final String password;

  SignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
