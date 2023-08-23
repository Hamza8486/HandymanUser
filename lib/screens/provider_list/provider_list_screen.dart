// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/persist_nev_bar.dart';
import 'package:user_apps/screens/provider_list/components/provider_list_box.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Dialogue/dialogue.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';


import 'controller/provider_list_controller.dart';

class ProviderListScreen extends StatefulWidget {
  ProviderListScreen({Key? key,this.data,this.data1}) : super(key: key);

  var data;
  var data1;

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  final providerController = Get.put(ProviderListController());



  final homeController = Get.put(HomeController());

  var value = "true";

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return  Scaffold(
            backgroundColor: AppColors.backColor,





            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  horizontal: size.width * 0.01,
                                  vertical: size.height * 0.008),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        homeController.updateSubId("");
                                        homeController.updateProvider("");

                                      });
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
                                  SizedBox(width: Get.width * 0.012,),
                                  AppText(
                                      title: "${widget.data.name}",
                                    size: Get.height * 0.018,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    color: AppColor.DARK_TEXT_COLOR,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        return
                          providerController.isProviderLoading.value
                              ? loader()
                              :
                          Expanded(child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProviderListView(),
                                SizedBox(height: Get.height*0.08,)
                              ],
                            ),
                          ));
                      }
                    ),



                  ],
                ),



                Positioned(
                  bottom: 10,
                  right: 7,
                  left: 7,
                  child:  GestureDetector(
                  onTap: (){
                    homeController
                        .updateSubId(
                        widget.data1==true?widget.data.subId.toString():
                        widget.data.id.toString());
                    homeController.updateProvider("");

                    providerController.updateValue("true");


                    Get.to(HomeScreen(currentIndex: 2),);
                  },
                  child: Container(
                    width: Get.width,

                    height: 50.0,
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text('Создать заявку',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),)
              ],
            ),
          );

  }
}