import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/core/model/item_model.dart';
import 'package:briz_grit/provider/hive_database.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/custome_text_field.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class ItemsScreen extends StatefulWidget {
  ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _retailPriceController = TextEditingController();

  final _wholesalePrizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customeSpacer(context, height: .02),
        const TopHead(),
        customeSpacer(context, height: .02),
        FutureBuilder(
            future: HiveDatabase().getAllItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return progressIndicator;
              }
              final itemList = snapshot.data!;

              return Expanded(
                child: itemList.isEmpty
                    ? emptyWidget('No Item')
                    : ListView.builder(
                        itemCount: itemList.length,
                        itemBuilder: (context, index) =>
                            SwipeableTile.swipeToTriggerCard(
                          verticalPadding: AppDimensions.paddingSizeExtraSmall,
                          shadow: appShadow,
                          horizontalPadding: AppDimensions.paddingSizeDefault,
                          onSwiped: (direction) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shadowColor:
                                    AppColors.appPrimaryGreen.withOpacity(.5),
                                alignment: Alignment.center,
                                backgroundColor: AppColors.bgColor,
                                title: SizedBox(
                                  child: Column(
                                    children: [
                                      cutomTextField(
                                          'Enter ratail rate',
                                          'Retail(₹)',
                                          _retailPriceController,
                                          (value) {},
                                          keyboardType: TextInputType.number),
                                      customeSpacer(context, height: .04),
                                      cutomTextField(
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
                                  customeSpacer(context, height: .01),
                                  customButton('Update', () {
                                    if (_retailPriceController
                                            .text.isNotEmpty &&
                                        _wholesalePrizeController
                                            .text.isNotEmpty) {
                                      final margin = double.parse(
                                              _retailPriceController.text) -
                                          double.parse(
                                              _wholesalePrizeController.text);
                                      HiveDatabase().updateItem(ItemModel(
                                          id: itemList[index].id,
                                          margin: margin.toString(),
                                          retailRate:
                                              _retailPriceController.text,
                                          title: itemList[index].title,
                                          wholesaleRate:
                                              _wholesalePrizeController.text));
                                      setState(() {});
                                      Navigator.pop(context);
                                    }
                                  }, AppColors.green),
                                  customeSpacer(context, height: .03),
                                  customButton(disableShadow: true, 'Remove',
                                      () {
                                    HiveDatabase()
                                        .removeItem(itemList[index].id);
                                    setState(() {});
                                    Navigator.pop(context);
                                  }, AppColors.red)
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
                              padding: const EdgeInsets.all(
                                  AppDimensions.paddingSizeLarge),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusSizeSmall),
                                color: AppColors.white,
                                boxShadow: [appShadow],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: AppDimensions.w(context) * .19,
                                        child: Text(
                                          itemList[index].title,
                                          style: AppStyle.rationaleStyle(
                                            size: AppDimensions.fontSizeDefault,
                                            color: AppColors.bgColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        itemList[index].retailRate,
                                        style: AppStyle.rationaleStyle(
                                          size: AppDimensions.fontSizeDefault,
                                          color: AppColors.bgColor,
                                        ),
                                      ),
                                      Text(
                                        itemList[index].wholesaleRate,
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
                                              text:
                                                  '₹ ${itemList[index].margin}',
                                              style: AppStyle.rationaleStyle(
                                                size: AppDimensions
                                                    .fontSizeDefault,
                                                color:
                                                    AppColors.appPrimaryGreen,
                                              ))
                                        ],
                                      ))),
                                ],
                              )),
                        ),
                      ),
              );
            })
      ],
    );
  }
}

class TopHead extends StatelessWidget {
  const TopHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenMargin(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Item              ',
            style: AppStyle.rationaleStyle(
                size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
          ),
          Text(
            'Retail(₹)',
            style: AppStyle.rationaleStyle(
                size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
          ),
          Text(
            'Wholesale(₹)',
            style: AppStyle.rationaleStyle(
                size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
