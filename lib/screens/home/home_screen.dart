import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/provider/hive_database.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  padding:
                      const EdgeInsets.all(AppDimensions.paddingSizeExtraLarge),
                  // height: AppDimensions.w(context) * .8,
                  decoration: BoxDecoration(
                      boxShadow: [appShadow],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimensions.radiusSizeExtraLarge)),
                      color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Builder(builder: (context) {
                            return Text(
                              'Reset',
                              style: AppStyle.robotoStyle(
                                  color: AppColors.lightRed,
                                  size: AppDimensions.fontSizeSmall,
                                  fontWeight: FontWeight.w600),
                            );
                          }),
                          customeSpacer(context, width: .02),
                          Consumer<HiveDatabase>(
                              builder: (context, controller, _) {
                            return InkWell(
                              onTap: () async {
                                controller.resetLastDayData();
                              },
                              child: const Icon(
                                color: AppColors.lightRed,
                                SolarIconsOutline.refreshCircle,
                              ),
                            );
                          })
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
                      Consumer<HiveDatabase>(
                          builder: (context, hiveController, _) {
                        return FutureBuilder(
                            future: hiveController.calculateTotlaMargin(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: Text('calculating...'),
                                );
                              }
                              return Column(
                                children: [
                                  customeSpacer(context, height: .01),
                                  SizedBox(
                                    width: AppDimensions.w(context),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Margin',
                                          style: AppStyle.rationaleStyle(
                                              color: AppColors.green
                                                  .withOpacity(.3),
                                              size: AppDimensions
                                                  .fontSizeOverLarge,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          '₹ ${hiveController.totalMargin}',
                                          style: AppStyle.rationaleStyle(
                                              enableShadow: true,
                                              color: AppColors.green,
                                              size: AppDimensions
                                                  .fontSizeOverLarge,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.w(context),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Sales',
                                          style: AppStyle.rationaleStyle(
                                              color: AppColors.lightRed
                                                  .withOpacity(.5),
                                              size: AppDimensions
                                                  .fontSizeOverLarge,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          '₹ ${hiveController.totalSales}',
                                          style: AppStyle.rationaleStyle(
                                              enableShadow: true,
                                              color: AppColors.red,
                                              size: AppDimensions
                                                  .fontSizeOverLarge,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ScreenMargin(
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
                const HistoryHead(),
                customeSpacer(context, height: .03),
                const HistoryList()
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: HiveDatabase().getHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return progressIndicator;
            }
            final historyData = snapshot.data;
            return historyData!.isEmpty
                ? emptyWidget('No History')
                : ListView.separated(
                    itemCount: historyData.length,
                    separatorBuilder: (context, index) =>
                        customeSpacer(context, height: .01),
                    itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(
                            AppDimensions.paddingSizeLarge),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSizeSmall),
                          color: AppColors.white,
                          boxShadow: [appShadow],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              historyData[index].date,
                              style: AppStyle.rationaleStyle(
                                size: AppDimensions.fontSizeDefault,
                                color: AppColors.bgColor,
                              ),
                            ),
                            Text(
                              historyData[index].totalSales,
                              style: AppStyle.rationaleStyle(
                                size: AppDimensions.fontSizeDefault,
                                color: AppColors.bgColor,
                              ),
                            ),
                            Text(
                              historyData[index].totalMargin,
                              style: AppStyle.rationaleStyle(
                                size: AppDimensions.fontSizeDefault,
                                color: AppColors.appPrimaryGreen,
                              ),
                            ),
                          ],
                        )));
          }),
    );
  }
}

class HistoryHead extends StatelessWidget {
  const HistoryHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Date              ',
          style: AppStyle.rationaleStyle(
              size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
        ),
        Text(
          'Sales(₹)',
          style: AppStyle.rationaleStyle(
              size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
        ),
        Text(
          'Margin(₹)',
          style: AppStyle.rationaleStyle(
              size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
