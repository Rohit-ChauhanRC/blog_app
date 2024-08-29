import 'package:blog_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failures, T>>;

typedef DataMap = Map<String, dynamic>;
