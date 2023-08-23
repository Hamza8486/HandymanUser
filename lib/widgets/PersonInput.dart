import 'package:flutter/material.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';


class PersonalWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const PersonalWidget(
      {Key? key,
      this.hintText = "",
      this.controller,
      this.textInputAction,
      this.keyboardType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.BLACK_COLOR.withOpacity(0.5))),
      child: TextField(
        style: TextStyle(fontFamily: Weights.medium),
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 15),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14.5, horizontal: 10)),
      ),
    );
  }
}
