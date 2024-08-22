import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<Sucesstype, Params> {
  Future<Either<Failures, Sucesstype>> call(Params params);
}
