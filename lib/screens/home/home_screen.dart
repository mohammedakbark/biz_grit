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
              color: AppColors.black,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              size: AppDimensions.fontSizeExtraLarge),
        ),
      ),
      backgroundColor: AppColors.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      color: AppColors.appPrimaryGreen),
                  child: SafeArea(
                    child: ScreenMargin(
                      child: Text(
                        'Daily based Sales &\nMargin',
                        style: AppStyle.rationaleStyle(
                            letterSpacing: 1,
                            size: AppDimensions.fontSizeExtraLarge,
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
                              blurRadius: 20,
                              blurStyle: BlurStyle.normal,
                              offset: const Offset(2.5, 5),
                              color: AppColors.appPrimaryGreen.withOpacity(.5))
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
                            const Spacer(),
                            Text(
                              'Reset',
                              style: AppStyle.robotoStyle(
                                  color: AppColors.lightRed,
                                  size: AppDimensions.fontSizeSmall,
                                  fontWeight: FontWeight.w600),
                            ),
                            customeSpacer(context, width: .02),
                            const Icon(
                              color: AppColors.lightRed,
                              SolarIconsOutline.refreshCircle,
                            )
                          ],
                        ),
                        Center(
                          child: Text(
                            'TODAY',
                            style: AppStyle.rationaleStyle(
                                color: AppColors.appPrimaryGreen,
                                size: AppDimensions.fontSizeMaxLarge,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        const Divider(
                          color: AppColors.appPrimaryGreen,
                        ),
                        customeSpacer(context, height: .01),
                        SizedBox(
                          width: AppDimensions.w(context),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Margin',
                                style: AppStyle.rationaleStyle(
                                    color: AppColors.green.withOpacity(.3),
                                    size: AppDimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                '₹ 98489.0',
                                style: AppStyle.rationaleStyle(
                                    enableShadow: true,
                                    color: AppColors.green,
                                    size: AppDimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: AppDimensions.w(context),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Sales',
                                style: AppStyle.rationaleStyle(
                                    color: AppColors.lightRed.withOpacity(.5),
                                    size: AppDimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                '₹ 10773668.0',
                                style: AppStyle.rationaleStyle(
                                    enableShadow: true,
                                    color: AppColors.red,
                                    size: AppDimensions.fontSizeOverLarge,
                                    fontWeight: FontWeight.bold),
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
          ),
          ScreenMargin(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customeSpacer(context, height: .02),
                Text(
                  'History',
                  style: AppStyle.rationaleStyle(
                      size: AppDimensions.fontSizeExtraLarge,
                      fontWeight: FontWeight.bold),
                ),
                customeSpacer(context, height: .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: AppStyle.rationaleStyle(
                          size: AppDimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Sales(₹)',
                      style: AppStyle.rationaleStyle(
                          size: AppDimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Margin(₹)',
                      style: AppStyle.rationaleStyle(
                          size: AppDimensions.fontSizeLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: AppDimensions.h(context) * .08,
        child: BottomNavigationBar(
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.bgColor,
            backgroundColor: AppColors.appPrimaryGreen,
            items: const [
              BottomNavigationBarItem(
                  label: '', icon: Icon(SolarIconsOutline.home)),
              BottomNavigationBarItem(
                  label: '', icon: Icon(SolarIconsOutline.penNewSquare)),
              BottomNavigationBarItem(
                  label: '',
                  icon: Icon(SolarIconsOutline.calculatorMinimalistic))
            ]),
      ),
    );
  }
}
