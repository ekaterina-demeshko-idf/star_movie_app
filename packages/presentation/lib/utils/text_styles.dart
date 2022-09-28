import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';

class AppFonts {
  AppFonts._();

  static const sfProText = '.SF Pro Text';
  static const bold = FontWeight.w500;
  static const regular = FontWeight.w400;
}

class AppTextStyles {
  AppTextStyles._();

  static const header = fontSize_28;

  static const fontSize_60 = 60.0;
  static const fontSize_42 = 42.0;
  static const fontSize_36 = 36.0;
  static const fontSize_34 = 34.0;
  static const fontSize_32 = 32.0;
  static const fontSize_30 = 30.0;
  static const fontSize_28 = 28.0;
  static const fontSize_26 = 26.0;
  static const fontSize_24 = 24.0;
  static const fontSize_22 = 22.0;
  static const fontSize_20 = 20.0;
  static const fontSize_18 = 18.0;
  static const fontSize_17 = 17.0;
  static const fontSize_16 = 16.0;
  static const fontSize_15 = 15.0;
  static const fontSize_14 = 14.0;
  static const fontSize_13 = 13.0;
  static const fontSize_12 = 12.0;
  static const fontSize_11 = 11.0;
  static const fontSize_10 = 10.0;
  static const fontSize_9 = 9.0;
  static const fontSize_8 = 8.0;
  static const fontSize_7 = 7.0;
  static const fontSize_5 = 5.0;

  static TextStyle headerStyle(
    double fontSize, {
    String fontFamily = AppFonts.sfProText,
    FontWeight fontWeight = AppFonts.regular,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight,
    FontStyle fontStyle = FontStyle.normal,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      color: PrimaryColors.white,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      height: (lineHeight ?? fontSize) / fontSize,
    );
  }

  static TextStyle descriptionStyle(
    double fontSize, {
    String fontFamily = AppFonts.sfProText,
    FontWeight fontWeight = AppFonts.regular,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight,
    FontStyle fontStyle = FontStyle.normal,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      color: PrimaryColors.whiteWithOpacity70,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      height: (lineHeight ?? fontSize) / fontSize,
    );
  }

  static TextStyle linkStyle(
    double fontSize, {
    String fontFamily = AppFonts.sfProText,
    FontWeight fontWeight = AppFonts.regular,
    TextDecoration decoration = TextDecoration.none,
    double? lineHeight,
    FontStyle fontStyle = FontStyle.normal,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      color: PrimaryColors.primaryLink,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      height: (lineHeight ?? fontSize) / fontSize,
    );
  }
}
