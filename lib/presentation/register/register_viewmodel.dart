import 'dart:async';
import 'dart:io';

import 'package:learn_flutter/app/functions.dart';
import 'package:learn_flutter/domain/usecase/register_usecase.dart';
import 'package:learn_flutter/presentation/base/base_viewmodel.dart';
import 'package:learn_flutter/presentation/common/freezed_data_classes.dart';
import 'package:learn_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:learn_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<String>.broadcast();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

// Inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobilePhone => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUsername => _userNameStreamController.sink;

// Outputs Error
  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid Email");

  @override
  Stream<String?> get outputErrorMobilePhone => outputIsMobilePhoneValid
      .map((isPhoneValid) => isPhoneValid ? null : "Invalid Phone");

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid Username");

// Outputs Valid
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsMobilePhoneValid =>
      _mobileNumberStreamController.stream
          .map((mobilePhone) => _isMobileNumberValid(mobilePhone));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<File?> get outputIsProfilePictureValid =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  register() async {
    print(registerObject);
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
          registerObject.mobileNumber,
          registerObject.countryMobilePhone,
          registerObject.userName,
          registerObject.email,
          registerObject.password,
          registerObject.profilePicture),
    ))
        .fold(
            (failure) => {
                  // Left or Failure
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      // Right or Success
      inputState.add(ContentState());
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobilePhone(String mobilePhone) {
    inputMobilePhone.add(mobilePhone);
    if (_isMobileNumberValid(mobilePhone)) {
      registerObject = registerObject.copyWith(mobileNumber: mobilePhone);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    _validate();
  }

  @override
  setContryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobilePhone: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobilePhone: "");
    }
    _validate();
  }

  // Private functions
  bool _isUserNameValid(String username) {
    return username.length >= 8;
  }

  bool _isMobileNumberValid(String mobilePhone) {
    return mobilePhone.length > 10;
  }

  bool _isPasswordValid(String password) {
    return password.length > 6;
  }

  bool _validateAllInputs() {
    return registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.countryMobilePhone.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty &&
        registerObject.userName.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  @override
  Sink get inputAllInputsValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputValidStreamController.stream
          .map((event) => _validateAllInputs());
}

abstract class RegisterViewModelInput {
  register();

  setUserName(String userName);
  setMobilePhone(String mobilePhone);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  setContryCode(String countryCode);

  Sink get inputUsername;
  Sink get inputMobilePhone;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAllInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobilePhoneValid;
  Stream<String?> get outputErrorMobilePhone;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File?> get outputIsProfilePictureValid;

  Stream<bool> get outputIsAllInputsValid;
}
