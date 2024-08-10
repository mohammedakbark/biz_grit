import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/screens/home/home_screen.dart';
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
          createRoute(const HomeScreen()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      style: AppStyle.poppinsStyle(
                        size: AppDimensions.fontSizeMaxLarge,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                      ),
                      TextSpan(
                          text: 'Biz',
                          style: AppStyle.poppinsStyle(),
                          children: [
                            TextSpan(
                                text: 'Grit',
                                style: AppStyle.poppinsStyle(
                                    color: AppColors.blue))
                          ])),
                ));
          },
          // child: Text.rich(
          //     style: AppStyle.poppinsStyle(
          //       size: AppDimensions.fontSizeMaxLarge,
          //       letterSpacing: 1,
          //       fontWeight: FontWeight.w900,
          //     ),
          //     TextSpan(
          //         text: 'Biz',
          //         style: AppStyle.poppinsStyle(),
          //         children: [
          //           TextSpan(
          //               text: 'Grit',
          //               style:
          //                   AppStyle.poppinsStyle(color: AppColors.blue))
          //         ]))
        )),
        bottomNavigationBar: SizedBox(
            height: AppDimensions.h(context) * .05,
            child: Column(
              children: [
                Text(
                  'Designed & developed by',
                  style: AppStyle.poppinsStyle(fontWeight: FontWeight.w100),
                ),
                Text(
                  'ZMAC',
                  style: AppStyle.poppinsStyle(letterSpacing: 1),
                )
              ],
            )));
  }
}
