import 'package:flutter/material.dart';
import 'package:learn_flutter/app/di.dart';
import 'package:learn_flutter/presentation/forgot_password/forgot_password_screen.dart';
import 'package:learn_flutter/presentation/login/login_screen.dart';
import 'package:learn_flutter/presentation/main/main_screen.dart';
import 'package:learn_flutter/presentation/onboarding/onboarding_screen.dart';
import 'package:learn_flutter/presentation/register/register_screen.dart';
import 'package:learn_flutter/presentation/resources/strings_manager.dart';
import 'package:learn_flutter/presentation/splash/splash_screen.dart';
import 'package:learn_flutter/presentation/store_details/store_details_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => StoreDetailsScreen());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppString.notRouteFound)),
      ),
    );
  }
}
