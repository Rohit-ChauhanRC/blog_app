import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignupUsecase implements Usecase<String, SignupParams> {
  final AuthRepository repository;

  SignupUsecase({required this.repository});
  @override
  Future<Either<Failures, String>> call(SignupParams params) async {
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
