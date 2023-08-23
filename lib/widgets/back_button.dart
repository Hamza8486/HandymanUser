import 'package:flutter/material.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';

Widget backBtn({required BuildContext context, required VoidCallback onTap}) {
  var size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: size.height * 0.05,
      width: size.width * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.LIGHT_GREY_COLOR.withOpacity(0.5),
          )),
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(left: 6),
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColor.DARK_TEXT_COLOR,
          size: 16,
        ),
      )),
    ),
  );
}
