import 'package:dartz/dartz.dart';
import 'package:learn_flutter/data/network/failure.dart';
import 'package:learn_flutter/data/request/request.dart';
import 'package:learn_flutter/domain/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
}
