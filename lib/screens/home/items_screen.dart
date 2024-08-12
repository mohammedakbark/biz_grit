import 'dart:developer';

import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/custome_text_field.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ItemsScreen extends StatelessWidget {
  ItemsScreen({super.key});

  final _retailPriceController = TextEditingController();
  final _wholesalePrizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customeSpacer(context, height: .02),
        ScreenMargin(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Item              ',
                style: AppStyle.rationaleStyle(
                    size: AppDimensions.fontSizeLarge,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Wholesale(₹)',
                style: AppStyle.rationaleStyle(
                    size: AppDimensions.fontSizeLarge,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'Retail(₹)',
                style: AppStyle.rationaleStyle(
                    size: AppDimensions.fontSizeLarge,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        customeSpacer(context, height: .02),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => SwipeableTile.swipeToTriggerCard(
              verticalPadding: AppDimensions.paddingSizeDefault,
              shadow: appShadow,
              horizontalPadding: AppDimensions.paddingSizeDefault,
              onSwiped: (direction) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    alignment: Alignment.center,
                    backgroundColor: AppColors.bgColor,
                    title: SizedBox(
                      child: Column(
                        children: [
                          cutomeTextField('Enter ratail rate', 'Retail(₹)',
                              _retailPriceController, (value) {},
                              keyboardType: TextInputType.number),
                          customeSpacer(context, height: .04),
                          cutomeTextField(
                              'Enter Wholesale rate',
                              'Wholesale(₹)',
                              _wholesalePrizeController,
                              keyboardType: TextInputType.number,
                              (value) {}),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      customButton('Update', () {}, AppColors.green),
                      customButton('Remove', () {}, AppColors.red)
                    ],
                  ),
                );
              },
              color: AppColors.bgColor,
              behavior: HitTestBehavior.opaque,
              key: UniqueKey(),
              backgroundBuilder: (context, direction, progress) {
                if (direction == SwipeDirection.endToStart) {
                  return Container(
                    padding: const EdgeInsets.only(
                        right: AppDimensions.paddingSizeExtraLarge),
                    alignment: Alignment.centerRight,
                    color: AppColors.appPrimaryGreen,
                    child: Text(
                      'Update',
                      style: AppStyle.rationaleStyle(
                          size: AppDimensions.fontSizeExtraLarge,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                }
                return const SizedBox();
              },
              child: Container(
                  margin: const EdgeInsets.only(
                      top: AppDimensions.paddingSizeSmall),
                  padding: const EdgeInsets.all(AppDimensions.paddingSizeLarge),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusSizeSmall),
                    color: AppColors.white,
                    boxShadow: [appShadow],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: AppDimensions.w(context) * .19,
                            child: Text(
                              index.isEven
                                  ? 'Gold mininghjjhjhbbjbbjbjb'
                                  : 'Milk',
                              style: AppStyle.rationaleStyle(
                                size: AppDimensions.fontSizeDefault,
                                color: AppColors.bgColor,
                              ),
                            ),
                          ),
                          Text(
                            '10202020',
                            style: AppStyle.rationaleStyle(
                              size: AppDimensions.fontSizeDefault,
                              color: AppColors.bgColor,
                            ),
                          ),
                          Text(
                            '1020200',
                            style: AppStyle.rationaleStyle(
                              size: AppDimensions.fontSizeDefault,
                              color: AppColors.bgColor,
                            ),
                          ),
                        ],
                      ),
                      customeSpacer(context, height: .01),
                      Container(
                          padding: const EdgeInsets.all(
                              AppDimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                              color: AppColors.bgColor,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusSizeLarge)),
                          child: Text.rich(TextSpan(
                            text: 'Margin  ',
                            style: AppStyle.rationaleStyle(
                              size: AppDimensions.fontSizeDefault,
                              color: AppColors.white,
                            ),
                            children: [
                              TextSpan(
                                  text: '₹ 20',
                                  style: AppStyle.rationaleStyle(
                                    size: AppDimensions.fontSizeDefault,
                                    color: AppColors.appPrimaryGreen,
                                  ))
                            ],
                          ))),
                    ],
                  )),
            ),
          ),
        )
      ],
    );
  }
}
