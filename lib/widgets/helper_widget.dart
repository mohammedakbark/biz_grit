import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:flutter/material.dart';

Widget customeSpacer(BuildContext context, {double? width, double? height}) {
  return SizedBox(
    height: height == null ? 0 : AppDimensions.h(context) * height,
    width: width == null ? 0 : AppDimensions.w(context) * width,
  );
}
