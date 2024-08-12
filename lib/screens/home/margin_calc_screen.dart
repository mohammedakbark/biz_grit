import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/provider/state_controller.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/custome_text_field.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class MarginCalcScreen extends StatelessWidget {
  MarginCalcScreen({super.key});
  final _searchController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> data = [
    'Milk',
    'Curd',
    'Milk 23',
    'Thyr',
    'More',
    'Neyy',
    'Milk Powder',
    'Food'
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenMargin(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            customeSpacer(context, height: .05),
            Consumer<StateController>(builder: (context, controller, _) {
              return cutomeTextField(
                '',
                'Item',
                _searchController,
                (value) {
                  if (value!.isEmpty) {
                    return 'Enter the item';
                  } else {
                    return null;
                  }
                },
                onChanged: (searckKey) {
                  controller.checkSearchControllerNotEmpty(searckKey, data);
                },
                onTap: () {},
                onTapOutsid: (value) {},
              );
            }),
            customeSpacer(context, height: .01),
            Consumer<StateController>(builder: (context, controller, child) {
              return Visibility(
                visible: controller.enableSearchList,
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: AppDimensions.paddingSizeDefault),
                  padding: const EdgeInsets.all(AppDimensions.paddingSizeSmall),
                  constraints: const BoxConstraints(),
                  decoration: BoxDecoration(
                      boxShadow: [appShadow],
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                          bottomRight:
                              Radius.circular(AppDimensions.radiusSizeTen),
                          bottomLeft:
                              Radius.circular(AppDimensions.radiusSizeTen))),
                  child: controller.searchResult.isEmpty
                      ? Center(
                          child: Text(
                            'No Item Found',
                            style:
                                AppStyle.robotoStyle(color: AppColors.bgColor),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: AppColors.grey,
                          ),
                          shrinkWrap: true,
                          itemCount: controller.searchResult.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              _searchController.text =
                                  controller.searchResult[index];
                              controller.disAbleSearchList();
                            },
                            child: Text(
                              controller.searchResult[index],
                              style: AppStyle.robotoStyle(
                                  color: AppColors.bgColor),
                            ),
                          ),
                        ),
                ),
              );
            }),
            customeSpacer(context, height: .01),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: AppDimensions.w(context) * .4,
                  child: Consumer<StateController>(
                      builder: (context, controller, _) {
                    return cutomeTextField(
                        onTap: () {
                          controller.disAbleSearchList();
                        },
                        '',
                        'Quantity',
                        _quantityController,
                        (value) {
                          if (value!.isEmpty) {
                            return 'Enter the quantity';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number);
                  }),
                ),
                SizedBox(
                    height: AppDimensions.h(context) * .05,
                    width: AppDimensions.w(context) * .4,
                    child: customButton('Save', () {
                      if (_formKey.currentState!.validate()) {
                        final result =
                            StateController.checkTheValueContainInDatabase(
                                _searchController.text.trimRight(), data);

                        if (!result) {
                          showCustomeSnackBar(
                              context, 'This one not in your items !!', true);
                        } else {
                          showCustomeSnackBar(
                              context, 'Entry successful', false);
                          _quantityController.clear();
                          _searchController.clear();
                        }
                      }
                    }, AppColors.green)),
              ],
            ),
            customeSpacer(context, height: .02),
            Row(
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
            customeSpacer(context, height: .02),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(
                        top: AppDimensions.paddingSizeSmall),
                    padding:
                        const EdgeInsets.all(AppDimensions.paddingSizeLarge),
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
                                color: AppColors.appPrimaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            customeSpacer(context, height: .01),
          ],
        ),
      ),
    );
  }
}
