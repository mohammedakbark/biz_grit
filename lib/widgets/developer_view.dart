import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:flutter/material.dart';

Widget deveView(BuildContext context) => SizedBox(
    height: AppDimensions.h(context) * .05,
    child: Column(
      children: [
        Text(
          'Designed & developed by',
          style: AppStyle.robotoStyle(
              color: AppColors.white,
              enableShadow: true,
              fontWeight: FontWeight.w100),
        ),
        Text(
          'ZMAC Solutions',
          style: AppStyle.robotoStyle(
              color: AppColors.white, enableShadow: true, letterSpacing: 1),
        )
      ],
    ));
