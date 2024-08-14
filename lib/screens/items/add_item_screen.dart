import 'dart:developer';

import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/core/model/item_model.dart';
import 'package:briz_grit/provider/hive_database.dart';
import 'package:briz_grit/provider/state_controller.dart';
import 'package:briz_grit/screens/navigation_screen.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/custome_text_field.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/route.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});

  final _retailPriceController = TextEditingController();
  final _wholesalePrizeController = TextEditingController();
  final _itemNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final hiveController = Provider.of<HiveDatabase>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          'Add Item',
          style: AppStyle.rationaleStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              size: AppDimensions.fontSizeExtraLarge(context)),
        ),
      ),
      body: ScreenMargin(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            customeSpacer(context, height: .04),
            cutomTextField(
                'Enter name of the item', 'Item name', _itemNameController,
                (value) {
              if (value!.isEmpty) {
                return 'Enter name of itme';
              } else {
                return null;
              }
            }),
            customeSpacer(context, height: .04),
            cutomTextField(
                'Enter ratail rate', 'Retail(₹)', _retailPriceController,
                (value) {
              if (value!.isEmpty) {
                return 'Enter retail prize of item';
              } else {
                return null;
              }
            }, keyboardType: TextInputType.number),
            customeSpacer(context, height: .04),
            cutomTextField('Enter Wholesale rate', 'Wholesale(₹)',
                _wholesalePrizeController, (value) {
              if (value!.isEmpty) {
                return 'Enter wholesale prize of item';
              } else {
                return null;
              }
            }, keyboardType: TextInputType.number),
            const Spacer(),
            SizedBox(
                height: AppDimensions.h(context) * .05,
                width: AppDimensions.w(context) * .5,
                child: customButton('Add', () {
                  if (_formKey.currentState!.validate()) {
                    final margin = double.parse(_retailPriceController.text) -
                        double.parse(_wholesalePrizeController.text);
                    log(margin.toString());

                    hiveController.addNewItem(
                        context,
                        ItemModel(
                            id: _itemNameController.text.trim(),
                            margin: margin.toString(),
                            retailRate: _retailPriceController.text.trim(),
                            title: _itemNameController.text.trim(),
                            wholesaleRate:
                                _wholesalePrizeController.text.trim()));
                    Navigator.pop(context);
                  }
                }, AppColors.green)),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      )),
      bottomNavigationBar:
          Consumer<StateController>(builder: (context, controller, _) {
        return bottomNavigation(context, controller.currentPage, (index) {
          controller.changePage(index);
          Navigator.of(context)
              .pushReplacement(createRoute(NavigationScreen()));
        });
      }),
    );
  }
}
