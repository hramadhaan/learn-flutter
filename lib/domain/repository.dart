import 'package:dartz/dartz.dart';
import 'package:learn_flutter/data/network/failure.dart';
import 'package:learn_flutter/data/request/request.dart';
import 'package:learn_flutter/data/responses/response.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationResponse>> login(
      LoginRequest loginRequest);
}
