// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/support_section/controllers/support_section_controller.dart';

class ExpandBox extends StatelessWidget {
  ExpandBox({Key? key,this.text,this.text1}) : super(key: key);

  final SupportSectionController supportSectionController =
  Get.put(SupportSectionController());

  var text;
  var text1;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Obx(
          () => Container(
        width: width,
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title:  Text(
             text,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            trailing: supportSectionController.expand.value == true
                ? const Icon(Icons.close, color: AppColors.blueColor)
                : const Icon(Icons.add, color: AppColors.blueColor),
            onExpansionChanged: (bool val) {
              supportSectionController.expand.value = val;
            },

            children:  [
              ListTile(
                title: Text(
                  text1,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
