import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_button.dart';


showAlertDialog(
    {required BuildContext context,
    required String text,
    required VoidCallback yesOnTap,
    bool isBoth = true}) {
  // set up the buttons
  Widget cancelButton = AppButton(
      buttonName: "да",
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: AppColor.primaryColor,
      textColor: Colors.white,
      onTap: yesOnTap);
  Widget continueButton = AppButton(
      buttonName: "нет",
      buttonWidth: 100,
      buttonHeight: 40,
      buttonRadius: BorderRadius.circular(10),
      buttonColor: Colors.transparent,
      textColor: AppColor.primaryColor,
      borderColor: AppColor.primaryColor,
      onTap: () {
        Get.back();
      });
  AlertDialog alert = AlertDialog(
    content: Text(text,style: TextStyle(fontFamily: Weights.medium),),
    actions: [
      cancelButton,
      isBoth ? continueButton : Container(),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
