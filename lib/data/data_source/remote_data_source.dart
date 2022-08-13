import 'package:learn_flutter/data/network/api.dart';
import 'package:learn_flutter/data/request/request.dart';
import 'package:learn_flutter/data/responses/response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    // TODO: implement login
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.emai,
      loginRequest.deviceType,
    );
  }
}
