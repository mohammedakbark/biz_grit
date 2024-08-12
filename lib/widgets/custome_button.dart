import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:flutter/material.dart';

Widget customButton(
  final String title,
  void Function()? onPressed,
  Color bgColor, {
  Color? textColor,
}) {
  return InkWell(
    // splashColor: Colors.amber,
    // highlightColor: Colors.white,

    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
    // hoverColor: Colors.redAccent,
    // focusColor: Colors.red,
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppDimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          boxShadow: [appShadow],
          color: bgColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSizeLarge)),
      child: Text(
        title,
        style: AppStyle.rationaleStyle(enableShadow: true, color: textColor),
      ),
    ),
  );
}
