import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/screens/home/home_screen.dart';
import 'package:briz_grit/screens/navigation_screen.dart';
import 'package:briz_grit/widgets/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    _goToHome();
  }

  void _goToHome() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          createRoute( NavigationScreen()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
          child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 1000),
        builder: (context, _val, child) {
          return Opacity(
              opacity: _val,
              child: Padding(
                padding: EdgeInsets.only(top: _val * 100),
                child: Text.rich(
                    style: AppStyle.rationaleStyle(
                      size: AppDimensions.fontSizeMaxLarge,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w900,
                    ),
                    TextSpan(
                        text: 'Biz',
                        style: AppStyle.rationaleStyle(
                          color: AppColors.white,
                          enableShadow: true,
                        ),
                        children: [
                          TextSpan(
                              text: 'Grit',
                              style: AppStyle.rationaleStyle(
                                  enableShadow: true,
                                  color: AppColors.appPrimaryGreen))
                        ])),
              ));
        },
      )),
      bottomNavigationBar: SizedBox(
          height: AppDimensions.h(context) * .05,
          child: Column(
            children: [
              Text(
                'Designed & developed by',
                style: AppStyle.robotoStyle(
                    color: AppColors.white,
                    enableShadow: true,
                    fontWeight: FontWeight.w100),
              ),
              Text(
                'ZMAC',
                style: AppStyle.robotoStyle(
                    color: AppColors.white,
                    enableShadow: true,
                    letterSpacing: 1),
              )
            ],
      ))
    );
  }
}
