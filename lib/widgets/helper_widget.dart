import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

Widget customeSpacer(BuildContext context, {double? width, double? height}) {
  return SizedBox(
    height: height == null ? 0 : AppDimensions.h(context) * height,
    width: width == null ? 0 : AppDimensions.w(context) * width,
  );
}

final appShadow = BoxShadow(
    blurRadius: 20,
    blurStyle: BlurStyle.normal,
    offset: const Offset(2.5, 5),
    color: AppColors.appPrimaryGreen.withOpacity(.5));
showCustomeSnackBar(BuildContext context, String message, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? AppColors.red : AppColors.green,
      content: Text(
        message,
        style: AppStyle.robotoStyle(),
      )));
}

succsessSnackBar() {}

const progressIndicator = Center(
  child: CircularProgressIndicator(
    color: AppColors.appPrimaryGreen,
  ),
);

Widget emptyWidget(String title) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.smart_toy_outlined,
          color: AppColors.white,
        ),
        Text(
          title,
          style: AppStyle.robotoStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
