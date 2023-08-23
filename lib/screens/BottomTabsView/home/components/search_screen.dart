import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/service_sub_all.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/sub_category.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/sub_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/provider_list/provider_list_screen.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';
import 'package:user_apps/widgets/back_button.dart';


class SearchScreenView extends StatefulWidget {
  SearchScreenView({Key? key}) : super(key: key);

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
  var fieldController = TextEditingController();

  final providerController = Get.put(ProviderListController());

  final homeController = Get.put(HomeController());

  final subCatController = Get.put(SubController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return Column(
          children: [
            Material(
              color: AppColor.WHITE_COLOR,
              elevation: 1,
              child: SizedBox(
                width: Get.width,
                height: Get.height / 8.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.01,
                          vertical: Get.height * 0.008),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              homeController.updateProvider("");
                                            homeController.updateSubId("");
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
                            title:"Поиск",
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
            SizedBox(
              height: Get.height * 0.02,),


            Padding(
              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
              child: Material(
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
                        subCatController.searchUpdate(searchKeyword: val.toString());

                        debugPrint(val);
                      }),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            subCatController.isNewLoading.value
                ? loader()
                : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                        child: Column(
                          children: [

                            Obx(
                                    () {
                                  return ListView.builder(
                                      itemCount: subCatController.servicesList.length,
                                      shrinkWrap: subCatController.servicesList.isNotEmpty?true: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,

                                      itemBuilder: (BuildContext context, int i) {
                                        return ListTile(
                                            onTap: (){
                                              providerController.providerData(
                                                  subCatId:
                                                  subCatController.servicesList[i].subId.toString());
                                              print(subCatController.servicesList[i].subId.toString());
                                              homeController
                                                  .updateSubId(subCatController.servicesList[i].subId.toString());

                                              Get.to(ProviderListScreen(data:subCatController.servicesList[i] ,
                                                data1: "true",

                                              ),
                                                  transition: Transition.rightToLeft);
                                            },
                                            trailing:Icon(Icons.arrow_forward_ios,size: Get.height*0.02,),
                                            title: Text(subCatController.servicesList[i].name??"",style: TextStyle(color: AppColor.BLACK_COLOR,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400,
                                                fontSize: Get.height*0.019
                                            ),));
                                      });
                                }
                            ),
                            Obx(
                                    () {
                                  return ListView.builder(
                                      itemCount: subCatController.subCatsList.length,
                                      shrinkWrap: subCatController.subCatsList.isNotEmpty?true: true,
                                      padding: EdgeInsets.zero,
                                      primary: false,

                                      itemBuilder: (BuildContext context, int i) {
                                        return ListTile(
                                            onTap: (){
                                              providerController.providerData(
                                                  subCatId:
                                                  subCatController.subCatsList[i].id.toString());
                                              print(subCatController.subCatsList[i].id.toString());
                                              homeController
                                                  .updateSubId(subCatController.subCatsList[i].id.toString());

                                              Get.to(ProviderListScreen(data:subCatController.subCatsList[i] ,),
                                                  transition: Transition.rightToLeft);
                                            },
                                            trailing:Icon(Icons.arrow_forward_ios,size: Get.height*0.02,),
                                            title: Text(subCatController.subCatsList[i].name.toString(),style: TextStyle(color: AppColor.BLACK_COLOR,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400,
                                                fontSize: Get.height*0.019
                                            ),));
                                      });
                                }
                            ),
                          ],
                        ),
                      ),
                    )
            ),

          ],
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
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height*0.019
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
