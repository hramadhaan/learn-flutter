import 'package:learn_flutter/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:learn_flutter/data/request/request.dart';
import 'package:learn_flutter/domain/model.dart';
import 'package:learn_flutter/domain/repository/repository.dart';
import 'package:learn_flutter/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;
  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(input.countryMobilePhone,
        input.userName, input.email, input.password, input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String mobileNumber;
  String countryMobilePhone;
  String userName;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(this.mobileNumber, this.countryMobilePhone,
      this.userName, this.email, this.password, this.profilePicture);
}
