import 'package:briz_grit/core/utils/responsive_text_size.dart';
import 'package:flutter/material.dart';

class AppDimensions {
  static double w(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double h(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double fontSizeExtraSmall(
    BuildContext context,
  ) =>
      responsiveTextSize(context, .02); //14.0;
  static double fontSizeSmall(BuildContext context) =>
      responsiveTextSize(context, .04); //16.0;
  static double fontSizeDefault(BuildContext context) =>
      responsiveTextSize(context, .05); // 18.0;
  static double fontSizeLarge(BuildContext context) =>
      responsiveTextSize(context, .06); //20.0;
  static double fontSizeExtraLarge(BuildContext context) =>
      responsiveTextSize(context, .065); //28.0;
  static double fontSizeOverLarge(BuildContext context) =>
      responsiveTextSize(context, .08); // 34.0;
  static double fontSizeMaxLarge(BuildContext context) =>
      responsiveTextSize(context, .14); //45.0;

  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeDefault = 15.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;

  static const double radiusSizeSmall = 5.0;
  static const double radiusSizeDefault = 8.0;
  static const double radiusSizeTen = 10.0;
  static const double radiusSizeLarge = 20.0;
  static const double radiusSizeExtraLarge = 50.0;
}
