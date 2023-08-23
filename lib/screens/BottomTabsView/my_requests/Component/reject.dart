

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_text.dart';


class RejectProvider extends StatefulWidget {
   RejectProvider({Key? key,this.jobId,this.postId}) : super(key: key);
  var jobId;
  var postId;

  @override
  State<RejectProvider> createState() => _RejectProviderState();
}

class _RejectProviderState extends State<RejectProvider> {
  final homeController = Get.put(HomeController());


  List rejectList = ["Слишком дорого",

    "Не приехал во время",
    "Не профессионал",
    "Другая причина"

  ];


  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      body: Column(
        children: [
          Material(
            color: AppColor.WHITE_COLOR,
            elevation: 1,
            child: SizedBox(
              width: size.width,
              height: size.height / 8.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.025,
                        vertical: size.height * 0.008),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            homeController.updateSelectValue("");
                            Get.back();
                          },
                          child: Container(
                            height: 35.0,
                            width: 35.0,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.primaryColor),

                            ),
                            child: const Center(
                              child: Icon(Icons.arrow_back,
                                  color: AppColors.blueColor, size: 24.0),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.02,),
                        AppText(
                            title: "Причина отмены",
                            size: size.height * 0.02,
                            color: AppColor.DARK_TEXT_COLOR,
                            fontFamily: Weights.semi),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: Get.height*0.02,),

                ListView.builder(
                    itemCount: rejectList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          homeController.updateSelectValue(rejectList[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Obx(
                                () {
                                  return Container(
                                    height:23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                      rejectList[index]==homeController.selectValue.value?

                                      AppColor.primaryColor:Colors.transparent,
                                      border: Border.all(color: AppColor.primaryColor)
                                    ),

                                  );
                                }
                              ),
                              SizedBox(width: Get.width * 0.02,),
                              AppText(
                                  title: rejectList[index],
                                  size: size.height * 0.022,
                                  fontWeight: FontWeight.w400,

                                  color: AppColor.DARK_TEXT_COLOR,
                                  fontFamily: "Poppins"),
                            ],
                          ),
                        ),
                      );
                    }
                      )
              ],
            ),
          )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppButton(buttonName: "Отменить", buttonColor: AppColor.primaryColor, textColor: AppColor.WHITE_COLOR, onTap: (){
              if(validate()){
                appLoader(context, AppColors.blueColor);
                print(widget.postId.toString());
                print(widget.jobId.toString(),);
                print(homeController.selectValue.value);


                      ApiManger().rejectProvider(
                          postId: widget.postId.toString(),
                          id: widget.jobId.toString(),
                          context: context);
              }
            },
            buttonRadius: BorderRadius.circular(10),
              buttonWidth: Get.width,
            ),
          )
        ],
      ),
    );
  }

  bool validate() {

    if (homeController.selectValue.value.isEmpty) {
      showErrorToast( 'Пожалуйста выберите причину');

      return false;
    }




    return true;
  }
}
