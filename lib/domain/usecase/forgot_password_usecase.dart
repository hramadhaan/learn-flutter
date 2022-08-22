import 'package:learn_flutter/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:learn_flutter/domain/repository/repository.dart';
import 'package:learn_flutter/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String email) async {
    // TODO: implement execute
    return await _repository.forgotPassword(email);
  }
}
