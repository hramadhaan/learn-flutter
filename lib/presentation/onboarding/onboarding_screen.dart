import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_flutter/domain/model.dart';
import 'package:learn_flutter/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:learn_flutter/presentation/resources/assets_manager.dart';
import 'package:learn_flutter/presentation/resources/color_manager.dart';
import 'package:learn_flutter/presentation/resources/routes_manager.dart';
import 'package:learn_flutter/presentation/resources/strings_manager.dart';
import 'package:learn_flutter/presentation/resources/values_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController(initialPage: 0);

  // ViewModel
  OnboardingViewModel _onboardingViewModel = OnboardingViewModel();

  _bind() {
    _onboardingViewModel.start();
  }

  @override
  void initState() {
    // TODO: implement initState
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onboardingViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SlideViewObject>(
        stream: _onboardingViewModel.outputSlideViewObject,
        builder: (context, snapShot) {
          return _getContentWidget(snapShot.data);
        });
  }

  Widget _getContentWidget(SlideViewObject? slideViewObject) {
    if (slideViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: ColorManager.white,
        body: PageView.builder(
          controller: _pageController,
          itemCount: slideViewObject.numOfSlides,
          onPageChanged: (index) {
            _onboardingViewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingWidget(slideViewObject.sliderObject);
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppString.skip,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
              _getBottomSheetWidget(slideViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircle);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    }
  }

  Widget _getBottomSheetWidget(SlideViewObject slideViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrow),
              ),
              onTap: () {
                _pageController.animateToPage(
                  _onboardingViewModel.goPrevious(),
                  duration: const Duration(
                    milliseconds: DurationContants.d300,
                  ),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < slideViewObject.numOfSlides; i++)
                Padding(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, slideViewObject.currentIndex),
                )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppPadding.p12),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrow),
              ),
              onTap: () {
                _pageController.animateToPage(
                  _onboardingViewModel.goNext(),
                  duration: const Duration(
                    milliseconds: DurationContants.d300,
                  ),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingWidget extends StatelessWidget {
  SliderObject _sliderObject;

  OnBoardingWidget(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
