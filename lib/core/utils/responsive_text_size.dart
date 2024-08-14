  import 'package:flutter/cupertino.dart';

double responsiveTextSize(BuildContext context, double scaleFactor) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Choose the basis for scaling. You can base it on width or height.
    double basis = screenWidth < screenHeight ? screenWidth : screenHeight;

    return basis * scaleFactor;
  }


  double responsivePadding(BuildContext context, double scaleFactor) {
  return MediaQuery.of(context).size.width * scaleFactor;
}

double responsiveRadius(BuildContext context, double scaleFactor) {
  return MediaQuery.of(context).size.width * scaleFactor;
}

double responsiveAspectRatio(BuildContext context, double widthFactor, double heightFactor) {
  double width = MediaQuery.of(context).size.width * widthFactor;
  double height = MediaQuery.of(context).size.height * heightFactor;
  return width / height;
}