import 'package:briz_grit/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextStyle poppinsStyle(
      {double? size,
      bool? enableShadow,
      Color? shadowColor,
      FontWeight? fontWeight,
      double? letterSpacing,
      Color? color}) {
    return GoogleFonts.poppins(
        shadows: [
          enableShadow != null
              ? Shadow(
                  offset: const Offset(2, 3),
                  color: shadowColor ?? AppColors.balck.withOpacity(.1))
              : const Shadow()
        ],
        color: color ?? AppColors.balck,
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
                  color: shadowColor ?? AppColors.balck.withOpacity(.1))
              : const Shadow()
        ],
        color: color ?? AppColors.balck,
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: letterSpacing);
  }

 
}
