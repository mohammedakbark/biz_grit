import 'package:briz_grit/core/constant/color.dart';
import 'package:briz_grit/core/constant/dimensions.dart';
import 'package:briz_grit/core/constant/style.dart';
import 'package:flutter/material.dart';

Widget cutomeTextField(
  String hintText,
  String lebel,
  TextEditingController? controller,
  String? Function(String?)? validator, {
    void Function()? onTap,
    void Function(PointerDownEvent)? onTapOutsid,void Function(String)? onChanged,
  TextInputType? keyboardType,
  int? maxLenght,
}) {
  return TextFormField(
    onTap: onTap,
    onTapOutside:onTapOutsid,
    onChanged:onChanged ,
    textCapitalization: TextCapitalization.sentences,
    keyboardType: keyboardType,
    maxLength: maxLenght,
    style: AppStyle.rationaleStyle(),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validator,
    cursorColor: AppColors.appPrimaryGreen,
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSizeDefault,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.appPrimaryGreen),
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSizeDefault,
            )),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.bgColor),
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusSizeDefault,
            )),
        label: Text(
          lebel,
          style:
              AppStyle.rationaleStyle(letterSpacing: 1, color: AppColors.white),
        ),
        hintStyle:
            AppStyle.robotoStyle(letterSpacing: 1, color: AppColors.white),
        hintText: hintText),
  );
}
