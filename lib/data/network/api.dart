import 'package:dio/dio.dart';
import 'package:learn_flutter/app/constant.dart';
import 'package:learn_flutter/data/responses/response.dart';
import 'package:retrofit/retrofit.dart';
part 'api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("imei") String emai,
    @Field("deviceType") String deviceType,
  );
}
