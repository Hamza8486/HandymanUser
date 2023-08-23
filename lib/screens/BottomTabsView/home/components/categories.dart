
// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/provider_list/provider_list_screen.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';

import 'sub_category.dart';


class AllCategories extends StatelessWidget {
  AllCategories({Key? key,}) : super(key: key);
  final homeController  = Get.put(HomeController());
  final providerController = Get.put(ProviderListController());
  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return


      Obx(
        () {
          return
            homeController.isPopLoading.value
                ? loader(height: Get.height * 0.05)
                :

            homeController.allPopList.isNotEmpty?
            GridView.builder(
            physics: const BouncingScrollPhysics(),
            // addAutomaticKeepAlives: true,
            padding: EdgeInsets.zero,
            gridDelegate:
            SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                size.height * 0.17,
                mainAxisExtent: size.height * 0.16,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10),
            shrinkWrap: true,
            // primary: true,
            itemCount: homeController.allPopList.length,

            itemBuilder: (
                BuildContext context,
                index,
                ) {
              // int value = index
              return


                _data(
                  context: context,
                  name: homeController.allPopList[index].name,
                  image: homeController.allPopList[index].image,
                  onTaps: () {
                    homeController.updateSubId(homeController.allPopList[index].id.toString());
                    providerController.providerData(
                        subCatId:
                        homeController.allPopList[index].id.toString());
                    print(homeController.allPopList[index].id.toString());



                    Get.to(ProviderListScreen(data:homeController.allPopList[index] ,),
                    transition: Transition.rightToLeft
                    );
                  });
            }):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.2,),
                Center(child: AppText(title: "No Data",
                  color: AppColor.DARK_TEXT_COLOR,
                  fontFamily: Weights.medium,

                )),
              ],
            );
        }
      );
  }

  Widget _data({
    required BuildContext context,
    onTaps,
    name,
    image,
  }) {
    return InkWell(
      onTap: onTaps,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    border: Border.all(color: AppColor.primaryColor,width: 1.5)

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network
                      (
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            "assets/images/1 - category.png",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                )
               ,
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Center(
                  child: Center(
                    child: AppText(
                      title: name,

                      overFlow: TextOverflow.ellipsis,
                      size: Get.height*0.017,
                      color: AppColors.blackColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
