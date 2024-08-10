import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:flutter/material.dart';

class ScreenMargin extends StatelessWidget {
  Widget child;
  ScreenMargin({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSizeLarge,
      ),
      child: child,
    );
  }
}
