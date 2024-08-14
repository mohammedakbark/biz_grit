import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/string.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/provider/auth_controller.dart';
import 'package:briz_grit/provider/hive_database.dart';
import 'package:briz_grit/provider/state_controller.dart';
import 'package:briz_grit/screens/home/home_screen.dart';
import 'package:briz_grit/screens/home/items_screen.dart';
import 'package:briz_grit/screens/home/margin_calc_screen.dart';
import 'package:briz_grit/screens/items/add_item_screen.dart';
import 'package:briz_grit/screens/splash_screen.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:briz_grit/widgets/route.dart';
import 'package:briz_grit/widgets/screen_margin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  List<Widget> pages = [const HomeScreen(), ItemsScreen(), MarginCalcScreen()];

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StateController>(context);

    return Scaffold(
        floatingActionButtonLocation: controller.currentPage == 1
            ? null
            : FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        floatingActionButton: controller.currentPage == 1
            ? FloatingActionButton(
                backgroundColor: AppColors.appPrimaryGreen,
                onPressed: () {
                  Navigator.of(context).push(createRoute(AddItemScreen()));
                },
                child: const Icon(color: AppColors.white, CupertinoIcons.add),
              )
            : controller.currentPage == 2
                ? floatingActionButton()
                : const SizedBox(),
        body: pages[controller.currentPage],
        appBar: AppBar(
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          centerTitle: true,
          title: Text(
            controller.currentPage == 0
                ? ''
                : controller.currentPage == 1
                    ? 'Items'
                    : controller.currentPage == 2
                        ? 'Margin Calc.'
                        : '',
            style: AppStyle.rationaleStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                size: AppDimensions.fontSizeExtraLarge(context)),
          ),
          leading: const SizedBox(),
          actions: [
            controller.currentPage == 0
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: AppDimensions.paddingSizeSmall),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shadowColor:
                                AppColors.appPrimaryGreen.withOpacity(.5),
                            alignment: Alignment.center,
                            backgroundColor: AppColors.bgColor,
                            title: Center(
                              child: Text(
                                'Log Out',
                                style: AppStyle.rationaleStyle(),
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              IconButton(
                                  onPressed: () async {
                                    final controller =
                                        Provider.of<HiveDatabase>(context,
                                            listen: false);

                                    await controller.cleanEntryBx();
                                    await controller.cleanHistoryBx();
                                    await controller.cleanItemBx();
                                    AuthController().logout();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        createRoute(const SpalshScreen()),
                                        (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.power_settings_new_outlined,
                                    color: AppColors.red,
                                  ))
                            ],
                          ),
                        );
                      },
                      child: Text(
                        Provider.of<AuthController>(context, listen: false)
                                .userData![ConstString.userName] ??
                            '',
                        style: AppStyle.rationaleStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w100,
                            size: AppDimensions.fontSizeDefault(context)),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        backgroundColor: AppColors.bgColor,
        bottomNavigationBar: bottomNavigation(
            context, controller.currentPage, controller.changePage));
  }

  Widget floatingActionButton() {
    return ScreenMargin(
      child: ScreenMargin(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSizeDefault,
              vertical: AppDimensions.paddingSizeExtraLarge),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusSizeDefault),
            color: AppColors.appPrimaryGreen.withOpacity(.7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Margin(₹)',
                style: AppStyle.rationaleStyle(enableShadow: true),
              ),
              Consumer<HiveDatabase>(builder: (context, hiveController, _) {
                return Text(
                  hiveController.totalMargin.toString(),
                  style: AppStyle.rationaleStyle(
                      enableShadow: true,
                      fontWeight: FontWeight.bold,
                      size: AppDimensions.fontSizeExtraLarge(context)),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

Widget bottomNavigation(
    BuildContext context, int index, void Function(int)? onTap) {
  return SizedBox(
    height: AppDimensions.h(context) * .08,
    child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        useLegacyColorScheme: false,
        currentIndex: index,
        onTap: onTap,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.bgColor,
        backgroundColor: AppColors.appPrimaryGreen,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              SolarIconsOutline.home,
            ),
          ),
          BottomNavigationBarItem(
              label: '', icon: Icon(SolarIconsOutline.penNewSquare)),
          BottomNavigationBarItem(
              label: '', icon: Icon(SolarIconsOutline.calculatorMinimalistic))
        ]),
  );
}
