import 'package:briz_grit/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextStyle rationaleStyle(
      {double? size,
      bool? enableShadow,
      Color? shadowColor,
      FontWeight? fontWeight,
      double? letterSpacing,
      Color? color}) {
    return GoogleFonts.rationale(
        shadows: [
          enableShadow != null
              ? Shadow(
                  offset: const Offset(2, 3),
                  color: shadowColor ?? AppColors.black.withOpacity(.1))
              : const Shadow()
        ],
        color: color ?? AppColors.white,
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: letterSpacing);
  }

  static TextStyle robotoStyle(
      {double? size,
      bool? enableShadow,
      Color? shadowColor,
      FontWeight? fontWeight,
      double? letterSpacing,
      Color? color}) {
    return GoogleFonts.roboto(
        shadows: [
          enableShadow != null
              ? Shadow(
                  offset: const Offset(2, 3),
                  color: shadowColor ?? AppColors.white.withOpacity(.1))
              : const Shadow()
        ],
        color: color ?? AppColors.white,
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: letterSpacing);
  }
}
