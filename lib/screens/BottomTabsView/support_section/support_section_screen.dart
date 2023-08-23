// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/res/images.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';


import 'components/expand_box.dart';
import 'components/social_button.dart';
import 'controllers/support_section_controller.dart';

class SupportSectionScreen extends GetView<SupportSectionController> {
  SupportSectionScreen({Key? key}) : super(key: key);

  final SupportSectionController supportSectionController =
      Get.put(SupportSectionController());

  whatsapp() async{
    var contact = "+996705771909";
    var androidUrl = "whatsapp://send?phone=$contact&text=Здраствуйте!";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Здраствуйте!')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{

    }
  }

  @override
  Widget build(BuildContext context) {
var size = Get.size;
    return Scaffold(
      backgroundColor: AppColors.backColor,

      body: Column(
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: size.width,
              height: size.height / 8.5 ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.018 ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          AppText(
                              title: "Служба поддержки",
                            size: Get.height * 0.018,
                            overFlow: TextOverflow.ellipsis,
                            color: AppColor.DARK_TEXT_COLOR,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,),
                          Icon(Icons.help),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*0.03,),

                  SocialButton(
                    onTap: () {
                      whatsapp();
                    },
                    borderColor: Colors.green,
                    btnText: 'Поддержка в WhatsApp',
                    iconPath: AppImages.whatsAppIcon,
                  ),
                  // const SizedBox(height: 10.0),
                  // SocialButton(
                  //   onTap: () {},
                  //   borderColor: AppColors.blueColor,
                  //   btnText: 'Support in Telegram',
                  //   iconPath: AppImages.telegramIcon,
                  // ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () {
                      return
                        supportSectionController.isLoading.value
                            ? Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.2,
                            ),
                            Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.blueColor,
                                )),
                          ],
                        )
                            :

                        ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 40.0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: supportSectionController.supportList.length,
                        itemBuilder: (context, index){
                          return ExpandBox(
                            text: supportSectionController.supportList[index].question,
                            text1: supportSectionController.supportList[index].answer,
                          );
                        },
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
