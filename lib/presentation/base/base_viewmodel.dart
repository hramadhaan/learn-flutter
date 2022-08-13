abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOuputs {}

abstract class BaseViewModelInputs {
  void start() {}
  void dispose() {}
}

abstract class BaseViewModelOuputs {}
