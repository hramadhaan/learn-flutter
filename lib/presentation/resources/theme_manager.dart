import 'package:flutter/material.dart';
import 'package:learn_flutter/presentation/resources/color_manager.dart';
import 'package:learn_flutter/presentation/resources/font_manager.dart';
import 'package:learn_flutter/presentation/resources/styles_manager.dart';
import 'package:learn_flutter/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // Main Colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,
      accentColor: ColorManager.grey,
      splashColor: ColorManager.primaryOpacity70,
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.primaryOpacity70,
        titleTextStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white),
          primary: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12)),
        ),
      ),
      textTheme: TextTheme(
        headline1: getSemiBoldStyle(
          color: ColorManager.darkGrey,
          fontSize: FontSize.s16,
        ),
        subtitle1: getMediumStyle(
          color: ColorManager.lightGrey,
          fontSize: FontSize.s14,
        ),
        subtitle2: getMediumStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s14,
        ),
        caption: getRegularStyle(color: ColorManager.grey1),
        bodyText1: getRegularStyle(color: ColorManager.grey),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p18),
        hintStyle: getRegularStyle(color: ColorManager.grey1),
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      )
      // Card View of the app
      // Appbar of the app
      // Button of the app
      // Text of the app
      // Input of the app
      );
}
