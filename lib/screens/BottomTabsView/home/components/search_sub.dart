// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/sub_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/provider_list/provider_list_screen.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';


class SearchSubView extends StatelessWidget {
  SearchSubView({Key? key}) : super(key: key);
  var fieldController = TextEditingController();
  final providerController = Get.put(ProviderListController());
  final homeController = Get.put(HomeController());
  final subController = Get.put(SubController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04, vertical: Get.height * 0.03),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_outlined,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(
                      width: Get.width * 0.2,
                    ),
                    AppText(
                      title: "Поиск",
                      color: AppColor.DARK_TEXT_COLOR,
                      size: 19,
                      fontFamily: Weights.semi,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Material(
                elevation: 2,
                color: AppColor.WHITE_COLOR,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.blackColor,
                          ),
                          hintText: "Услуга или специалист",
                          hintStyle: TextStyle(
                            color: AppColor.DARK_TEXT_COLOR.withOpacity(0.4),
                            fontFamily: Weights.regular,
                          ),
                          border: InputBorder.none),
                      controller: fieldController,
                      onChanged: (val) {
                        subController.searchUpdate(searchKeyword: val.toString());

                        debugPrint(val);
                      }),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              subController.isNewLoading.value
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.3,
                  ),
                  Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      )),
                ],
              )
                  : Expanded(
                child: fieldController.text.isNotEmpty
                    ? subController.searchList.isNotEmpty
                    ? ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),


                    itemCount:
                    subController.searchList.length,



                    itemBuilder: (context, index) {
                      return


                        subCategoryBox(
                          onTap: (){

                            providerController.providerData(subCatId: subController.searchList[index].id.toString());
                            homeController.updateSubId(subController.searchList[index].id.toString());

                            Get.to(ProviderListScreen());
                          },
                          text: subController.searchList[index].name,
                        );


                    })
                    : Center(
                  child: Center(
                    child: Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: AppColor.DARK_TEXT_COLOR,
                            size: Get.height * 0.03,
                          ),
                          AppText(
                              title: "No Service",
                              color: AppColor.DARK_TEXT_COLOR,
                              textAlign: TextAlign.center,
                              fontFamily: Weights.semi,
                              size: Get.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                )
                    : Center(
                  child: Center(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: AppColor.DARK_TEXT_COLOR,
                            size: Get.height * 0.03,
                          ),
                          AppText(
                              title: "Search Service\nhere",
                              color: AppColor.DARK_TEXT_COLOR,
                              textAlign: TextAlign.center,
                              fontFamily: Weights.semi,
                              size: Get.height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }


  Widget subCategoryBox({text,onTap}) {
    return  GestureDetector(
      onTap:onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        padding: const EdgeInsets.only(left: 16.0, top: 12.0, bottom: 12.0, right: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width*0.6,
              child: Text(text,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.blackColor,

                    overflow: TextOverflow.ellipsis,
                    fontFamily: Weights.medium
                ),
              ),
            ),
            IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.arrow_forward_ios, color: AppColors.greyColor, size: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
