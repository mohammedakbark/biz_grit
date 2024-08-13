import 'dart:developer';

import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/core/model/item_model.dart';
import 'package:briz_grit/core/model/single_entry_model.dart';
import 'package:briz_grit/provider/hive_database.dart';
import 'package:briz_grit/provider/state_controller.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/custome_text_field.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MarginCalcScreen extends StatelessWidget {
  MarginCalcScreen({super.key});
  final _searchController = TextEditingController();
  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<ItemModel> data = [];
  ItemModel? selectedItem;

  @override
  Widget build(BuildContext context) {
    return ScreenMargin(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            customeSpacer(context, height: .05),
            Consumer<StateController>(builder: (context, controller, _) {
              return cutomTextField(
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
                onTap: () async {
                  try {
                    data =
                        await Provider.of<HiveDatabase>(context, listen: false)
                            .getAllItems();
                  } catch (e) {
                    log(e.toString());
                  }
                },
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
                              selectedItem = controller.searchResult[index];
                              _searchController.text =
                                  controller.searchResult[index].title;
                              controller.disAbleSearchList();
                            },
                            child: Text(
                              controller.searchResult[index].title,
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
                    return cutomTextField(
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
                Consumer<HiveDatabase>(builder: (context, hiveController, _) {
                  return SizedBox(
                      height: AppDimensions.h(context) * .05,
                      width: AppDimensions.w(context) * .4,
                      child: customButton('Save', () async {
                        if (_formKey.currentState!.validate()) {
                          // final result =
                          //     StateController.checkTheValueContainInDatabase(
                          //         _searchController.text.trimRight(), data);

                          if (selectedItem == null) {
                            showCustomeSnackBar(
                                context, 'This one not in your items !!', true);
                          } else {
                            log(selectedItem.toString());
                            final id = DateTime.timestamp();

                            await hiveController
                                .addNewEntry(
                                    context,
                                    SingleEntryModel(
                                        sales:
                                            '${double.parse(selectedItem!.retailRate) * double.parse(_quantityController.text)}' ??
                                                '',
                                        id: id.toString(),
                                        margin:
                                            '${double.parse(selectedItem!.margin) * double.parse(_quantityController.text)}' ??
                                                '',
                                        quantity:
                                            _quantityController.text ?? '',
                                        title: _searchController.text ?? ''))
                                .then((value) {
                              _quantityController.clear();
                              _searchController.clear();
                            });
                          }
                        }
                      }, AppColors.green));
                }),
              ],
            ),
            customeSpacer(context, height: .02),
            const EntryHead(),
            customeSpacer(context, height: .02),
            const EntryList(),
            customeSpacer(context, height: .01),
          ],
        ),
      ),
    );
  }
}

class EntryList extends StatelessWidget {
  const EntryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDatabase>(builder: (context, hiveDatabse, _) {
      return Expanded(
        child: FutureBuilder(
            future: hiveDatabse.getEntries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return progressIndicator;
              }

              final entryList = hiveDatabse.entryList;
              return entryList.isEmpty || snapshot.data == null
                  ? emptyWidget('No Entries')
                  : ListView.builder(
                      itemCount: entryList.length,
                      itemBuilder: (context, index) => Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
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
                                        width: AppDimensions.w(context) * .25,
                                        child: Text(
                                          entryList[index].title,
                                          style: AppStyle.rationaleStyle(
                                            size: AppDimensions.fontSizeDefault,
                                            color: AppColors.bgColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        entryList[index].quantity,
                                        style: AppStyle.rationaleStyle(
                                          size: AppDimensions.fontSizeDefault,
                                          color: AppColors.bgColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppDimensions.w(context) * .2,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            '${double.parse(entryList[index].margin)}',
                                            style: AppStyle.rationaleStyle(
                                              size:
                                                  AppDimensions.fontSizeDefault,
                                              color: AppColors.appPrimaryGreen,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          IconButton(
                              onPressed: () async {
                                hiveDatabse.removeEntries(entryList[index].id);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 18,
                              )),
                        ],
                      ),
                    );
            }),
      );
    });
  }
}

class EntryHead extends StatelessWidget {
  const EntryHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Item              ',
          style: AppStyle.rationaleStyle(
              size: AppDimensions.fontSizeLarge, fontWeight: FontWeight.w600),
        ),
        Text(
          'Quantity',
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
