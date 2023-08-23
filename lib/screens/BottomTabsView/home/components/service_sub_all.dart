
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/search_sub.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/sub_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/provider_list/provider_list_screen.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';


class ServiceSubAll extends StatelessWidget {
  ServiceSubAll({Key? key,}) : super(key: key);

  final providerController = Get.put(ProviderListController());
  final homeController = Get.put(HomeController());
  final subController = Get.put(SubController());
  var fieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                        horizontal: Get.width * 0.025,
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
                            title:"Подкатегория",
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
          const SizedBox(height: 20.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: AppColor.WHITE_COLOR,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1),
              child: TextField(
                maxLines: 1,
                readOnly: true,
                onTap: () {
                  Get.to(SearchSubView());
                },
                decoration: InputDecoration(
                  hintText: "Услуга или специалист",
                  border: InputBorder.none,
                  prefixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 24.0,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Obx(
            () {
              return Expanded(
                  child:
                  subController.isSubLoading.value?loader():
                  subController.subSubList.isEmpty
                      ? Center(
                      child: AppText(
                        title: "Нет данных",
                        color: AppColors.blackColor,
                        fontFamily: Weights.medium,
                      ))
                      : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      itemCount: subController.subSubList.length,
                      itemBuilder: (context, index) {
                        return subCategoryBox(
                          onTap: () {
                            providerController.providerData(
                                subCatId:
                                subController.subSubList[index].id.toString());
                            homeController.updateSubId(subController.subSubList[index].id.toString());
                            Get.to(ProviderListScreen(data:subController.subSubList[index] ,),
                                transition: Transition.rightToLeft
                            );
                            // Get.to(ProviderListScreen(data:data.subCategory[index] ,));
                          },
                          text: subController.subSubList[index].name,
                        );
                      }));
            }
          ),
        ],
      ),
    );
  }

  Widget subCategoryBox({text, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        padding: const EdgeInsets.only(
            left: 16.0, top: 12.0, bottom: 12.0, right: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width * 0.6,
              child: Text(
                text,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.blackColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios,
                  color: AppColors.greyColor, size: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
