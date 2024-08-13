import 'dart:developer';

import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:briz_grit/provider/auth_controller.dart';
import 'package:briz_grit/widgets/custome_button.dart';
import 'package:briz_grit/widgets/custome_text_field.dart';
import 'package:briz_grit/widgets/developer_view.dart';
import 'package:briz_grit/widgets/helper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.paddingSizeLarge),
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSizeExtraLarge),
            width: AppDimensions.w(context),
            height: AppDimensions.w(context) * 1.1,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusSizeLarge),
                boxShadow: [appShadow],
                color: AppColors.bgColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login',
                    style: AppStyle.rationaleStyle(
                      size: AppDimensions.fontSizeOverLarge,
                    )),
                customeSpacer(context, height: .03),
                cutomTextField('', 'User Name', _userNameController, (value) {
                  if (value!.isEmpty) {
                    return 'Enter your user name !';
                  } else if (RegExp(r'\s').hasMatch(value)) {
                    return 'User name must not contain white space !';
                  } else {
                    return null;
                  }
                }),
                customeSpacer(context, height: .03),
                cutomTextField('', 'Password', _passwordController, (value) {
                  if (value!.isEmpty) {
                    return 'Enter your password !';
                  } else if (RegExp(r'\s').hasMatch(value)) {
                    return 'Password must not contain white space !';
                  } else {
                    return null;
                  }
                }),
                customeSpacer(context, height: .03),
                SizedBox(
                    width: AppDimensions.w(context) * .5,
                    height: 50,
                    child: customButton('Login', () {
                      if (_formKey.currentState!.validate()) {
                        AuthController().loginUser(
                          context,
                            _userNameController.text.trim(),
                            _passwordController.text.trim());
                      }
                    }, AppColors.appPrimaryGreen))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: deveView(context),
    );
  }
}
