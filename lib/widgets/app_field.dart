// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_dimensions.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    this.hint = "",
    this.hintColor,
    this.hintSize,
    this.textInputType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.isShowCursor = true,
    this.isReadOnly = false,
    this.maxLines,
    this.isVisible = true,
    this.enabled = true,
    this.isborderline = false,
    this.isBoxShadow = false,
    this.borderColor = Colors.orange,
    this.borderRadius = BorderRadius.zero,
    this.intialValue = "",
    this.onTap,
    this.obsecure = false,
    this.controller,
  }) : super(key: key);
  final bool obsecure;

  final TextEditingController? controller;
  final String hint;
  final bool isVisible;
  final bool enabled;
  final Color? hintColor;
  final double? hintSize;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final bool isShowCursor;
  final bool isReadOnly;
  final int? maxLines;
  final Color borderColor;
  final bool isborderline;
  final bool isBoxShadow;
  final BorderRadius borderRadius;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final String intialValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: this.obsecure,
      onTap: onTap,
      // initialValue: intialValue,
      maxLines: maxLines,

      showCursor: isShowCursor,
      cursorColor: AppColor.DARK_TEXT_COLOR,
      readOnly: isReadOnly,
      keyboardType: textInputType,
      textAlignVertical: TextAlignVertical.center,

      textInputAction: textInputAction,
      style: TextStyle(
          fontFamily: Weights.medium,
          fontSize: AppDimensions.FONT_SIZE_16,
          color: AppColor.DARK_TEXT_COLOR.withOpacity(0.7)),
      decoration: InputDecoration(
        fillColor: AppColor.WHITE_COLOR,
        filled: true,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        hintText: hint,
        suffixIcon: this.suffixIcon,
        prefixIcon: this.prefixIcon,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: hintSize,
        ),
        border: isborderline
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                ),
                borderRadius: borderRadius,
              )
            : null,
        enabledBorder: isborderline
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                ),
                borderRadius: borderRadius,
              )
            : null,
        disabledBorder: isborderline
            ? OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: borderColor),
                borderRadius: borderRadius,
              )
            : null,
        errorBorder: isborderline
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                ),
                borderRadius: borderRadius,
              )
            : null,
        focusedBorder: isborderline
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                ),
                borderRadius: borderRadius,
              )
            : null,
        focusedErrorBorder: isborderline
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor,
                ),
                borderRadius: borderRadius,
              )
            : null,
      ),
    );
  }
}
