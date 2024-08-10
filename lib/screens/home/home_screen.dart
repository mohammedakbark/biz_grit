import 'dart:ui';

import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '',
          style: AppStyle.robotoStyle(
              color: AppColors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              size: AppDimensions.fontSizeExtraLarge),
        ),
      ),
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          SizedBox(
            width: AppDimensions.w(context),
            height: AppDimensions.w(context) * 1,
            child: Stack(
              children: [
                Container(
                  width: AppDimensions.w(context),
                  height: AppDimensions.w(context) * .5,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(100, 50),
                          bottomRight: Radius.elliptical(100, 50)),
                      color: AppColors.blue),
                  child: SafeArea(
                    child: ScreenMargin(
                      child: Text(
                        'Daily based\nSales & Margin',
                        style: AppStyle.robotoStyle(
                            letterSpacing: 1,
                            size: AppDimensions.fontSizeOverLarge,
                            fontWeight: FontWeight.w900,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: AppDimensions.paddingSizeLarge,
                  right: AppDimensions.paddingSizeLarge,
                  bottom: 0,
                  child: Container(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(
                        AppDimensions.paddingSizeExtraLarge),
                    height: AppDimensions.w(context) * .8,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              offset: const Offset(5, 10),
                              color: AppColors.balck.withOpacity(.1))
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(
                            AppDimensions.radiusSizeExtraLarge)),
                        color: AppColors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Reset',
                              style: AppStyle.robotoStyle(
                                  color: AppColors.lightRed,
                                  size: AppDimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w600),
                            ),
                            customeSpacer(context, width: .02),
                            Icon(
                              color: AppColors.lightRed,
                              SolarIconsOutline.refreshCircle,
                            )
                          ],
                        ),
                        Center(
                          child: Text(
                            'TODAY',
                            style: AppStyle.poppinsStyle(
                                color: AppColors.bgColor,
                                size: AppDimensions.fontSizeMaxLarge,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const Divider(
                          color: AppColors.bgColor,
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customeSpacer(context, height: .02),
                              Text(
                                'Margin',
                                style: AppStyle.poppinsStyle(
                                    color: AppColors.green.withOpacity(.5),
                                    size: AppDimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                '₹ 98489.00',
                                style: AppStyle.poppinsStyle(
                                    enableShadow: true,
                                    color: AppColors.green,
                                    size: AppDimensions.fontSizeMaxLarge,
                                    fontWeight: FontWeight.w900),
                              ),
                              customeSpacer(context, height: .03),
                              Text(
                                'Sales',
                                style: AppStyle.poppinsStyle(
                                    color: AppColors.blue.withOpacity(.5),
                                    size: AppDimensions.fontSizeLarge,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                '₹ 10773668.00',
                                style: AppStyle.poppinsStyle(
                                    enableShadow: true,
                                    color: AppColors.blue,
                                    size: AppDimensions.fontSizeLarge,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
