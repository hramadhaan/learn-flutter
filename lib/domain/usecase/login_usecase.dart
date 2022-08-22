import 'package:learn_flutter/app/functions.dart';
import 'package:learn_flutter/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:learn_flutter/data/request/request.dart';
import 'package:learn_flutter/domain/model.dart';
import 'package:learn_flutter/domain/repository/repository.dart';
import 'package:learn_flutter/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository
        .login(LoginRequest(input.email, input.password, "", ""));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
