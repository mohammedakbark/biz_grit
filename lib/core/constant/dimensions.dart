import 'package:flutter/material.dart';

class AppDimensions {
  static double w(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double h(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const double fontSizeExtraSmall = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeDefault = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeExtraLarge = 24.0;
  static const double fontSizeOverLarge = 28.0;
  static const double fontSizeMaxLarge = 40.0;

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
