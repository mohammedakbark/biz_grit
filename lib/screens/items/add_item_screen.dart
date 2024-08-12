import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: Text(
          'Add Item',
          style: AppStyle.rationaleStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              size: AppDimensions.fontSizeExtraLarge),
        ),
      ),
      body: ScreenMargin(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            customeSpacer(context, height: .04),
            cutomeTextField('Enter name of the item', 'Item name',
                _itemNameController, (value) {}),
            customeSpacer(context, height: .04),
            cutomeTextField('Enter ratail rate', 'Retail(₹)',
                _retailPriceController, (value) {},
                keyboardType: TextInputType.number),
            customeSpacer(context, height: .04),
            cutomeTextField('Enter Wholesale rate', 'Wholesale(₹)',
                _wholesalePrizeController, (value) {},
                keyboardType: TextInputType.number),
            Spacer(),
            SizedBox(
                height: AppDimensions.h(context) * .05,
                width: AppDimensions.w(context) * .5,
                child: customButton('Update', () {}, AppColors.green)),
            Spacer(
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
