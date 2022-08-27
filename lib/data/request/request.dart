class LoginRequest {
  String email;
  String password;
  String emai;
  String deviceType;

  LoginRequest(this.email, this.password, this.emai, this.deviceType);
}

class RegisterRequest {
  String countryMobilePhone;
  String userName;
  String email;
  String password;
  String profilePicture;

  RegisterRequest(this.countryMobilePhone, this.userName, this.email,
      this.password, this.profilePicture);
}
