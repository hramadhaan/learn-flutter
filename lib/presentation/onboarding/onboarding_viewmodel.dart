import 'dart:async';

import 'package:learn_flutter/domain/model.dart';
import 'package:learn_flutter/presentation/base/base_viewmodel.dart';
import 'package:learn_flutter/presentation/resources/assets_manager.dart';
import 'package:learn_flutter/presentation/resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    // super.dispose();
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    // super.start();
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    // TODO: implement goNext
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  @override
  int goPrevious() {
    // TODO: implement goPrevious
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSlideViewObject
  Sink get inputSlideViewObject => _streamController.sink;

  @override
  // TODO: implement outputSlideViewObject
  Stream<SlideViewObject> get outputSlideViewObject =>
      _streamController.stream.map((event) => event);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppString.onBoardingTitle1, AppString.onBoardingSubTitle1,
            ImageAssets.onboardingLogo1),
        SliderObject(AppString.onBoardingTitle2, AppString.onBoardingSubTitle2,
            ImageAssets.onboardingLogo2),
        SliderObject(AppString.onBoardingTitle3, AppString.onBoardingSubTitle3,
            ImageAssets.onboardingLogo3),
        SliderObject(AppString.onBoardingTitle4, AppString.onBoardingSubTitle4,
            ImageAssets.onboardingLogo4)
      ];

  _postDataToView() {
    inputSlideViewObject.add(
        SlideViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();

  void goPrevious();

  void onPageChanged(int index);

  Sink get inputSlideViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSlideViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
