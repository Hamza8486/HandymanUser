// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/favorite/components/provider_detail.dart';
import 'package:user_apps/screens/provider_list/components/provider_list_box.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/AppDimensions/app_dimensions.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_text.dart';



class MyFavouriteScreen extends StatelessWidget {
   MyFavouriteScreen({Key? key}) : super(key: key);

  final profileController = Get.put(HomeController());
  final providerListController = Get.put(ProviderListController());

  @override
  Widget build(BuildContext context) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.018),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_outlined,
                                color: AppColors.blackColor,)),
                          SizedBox(width: Get.width * 0.03,),
                          AppText(
                              title: "Избранное",
                            size: Get.height * 0.018,
                            overFlow: TextOverflow.ellipsis,
                            color: AppColor.DARK_TEXT_COLOR,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
                  () {
                return
                  profileController.isFavLoading.value
                      ? loader()
                      :
                  profileController.allFavList.isNotEmpty
                      ?
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        shrinkWrap: true,
                        primary: false,
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount: profileController.allFavList.length,
                        itemBuilder: (context, index){
                          return  GestureDetector(
                            onTap: (){
                              Get.put(HomeController()).updateProvider("");
                              Get.to(


                                  FavouriteDetailScreen(data: profileController.allFavList[index],),
                              transition: Transition.rightToLeft
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                              padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50.0,
                                                width: 50.0,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: profileController.allFavList[index].image , fit: BoxFit.cover,
                                                    errorWidget:(context, url, error) => ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image.asset(
                                                          'assets/images/person.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),

                                                    placeholder: (context, url) =>


                                                    const Center(
                                                        child: CircularProgressIndicator(
                                                          color: AppColors.blueColor,
                                                        )),



                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12.0),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 5.0),
                                                  SizedBox(
                                                    width: Get.width*0.45,
                                                    child: Text(profileController.allFavList[index].firstName,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        color: AppColors.blackColor,
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children:  [
                                                      Icon(Icons.star, color: Colors.orangeAccent, size: 16.0),
                                                      Text(profileController.allFavList[index].avgRating.toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: AppColors.blackColor,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Icon(Icons.chat_bubble, color: AppColors.greyColor, size: 16.0),
                                                      SizedBox(width: 4.0),
                                                      Text(profileController.allFavList[index].ratingCount.toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: AppColors.blackColor,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(width: 6.0),
                                                      Text('отзывов',
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: AppColors.blackColor,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(

                                            children: [
                                              GestureDetector(
                                                  onTap: (){
                                                    appLoader(context,AppColor.primaryColor);
                                                    ApiManger().removeResponse(
                                                        context: context,
                                                        providerId: profileController.allFavList[index].id.toString(),
                                                        id: profileController.userId.value.toString(),
                                                        status:"0"

                                                    );
                                                  },
                                                  child: Icon(Icons.delete,color: Colors.red,))
                                            ],
                                          )
                                        ],

                                      ),

                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(profileController.allFavList[index].aboutMe,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: AppColors.blackColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.zero,
                                      itemCount: profileController.allFavList[index].service.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return  Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                                          child: Row(
                                            children: [
                                              Text(profileController.allFavList[index].service[i].name,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize:AppSizes.SIZE_13,
                                                  color: AppColors.blackColor.withOpacity(0.6),
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                ),

                                              ),
                                              SizedBox(width: Get.width*0.03,),
                                              Expanded(
                                                child: MySeparator(color: AppColors.blackColor.withOpacity(0.6),),
                                              ),
                                              SizedBox(width: Get.width*0.03,),
                                              Text("от ${profileController.allFavList[index].service[i].price.toString().split(".").first
                                              } сом",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize:AppSizes.SIZE_12,
                                                  color: AppColors.blackColor.withOpacity(0.6),
                                                  fontFamily: Weights.semi,

                                                  fontWeight: FontWeight.w500,
                                                ),

                                              ),

                                            ],
                                          ),
                                        );
                                      }),
                                  const SizedBox(height: 8.0),
                                  Obx(
                                          () {
                                        return
                                          profileController.allFavList[index].portfolio.isEmpty?SizedBox.shrink():
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              height: Get.height*0.1,
                                              child: ListView.builder(
                                                  itemCount: profileController.allFavList[index].portfolio.length,
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (BuildContext context, int ind) {
                                                    return Container(


                                                      margin: EdgeInsets.symmetric(horizontal:Get.width*0.02,vertical: 5),
                                                      width: Get.height*0.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: AppColors.blueColor,width: 2),
                                                        borderRadius: BorderRadius.circular(10),


                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: CachedNetworkImage(
                                                          imageUrl:profileController.allFavList[index].portfolio[ind].image, fit: BoxFit.cover,
                                                          errorWidget:(context, url, error) => ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(10),
                                                              child: Image.asset(
                                                                'assets/images/person.png',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),

                                                          placeholder: (context, url) =>


                                                          const Center(
                                                              child: CircularProgressIndicator(
                                                                color: AppColors.blueColor,
                                                              )),



                                                        ),
                                                      ),

                                                    );
                                                  }),
                                            ),
                                          );
                                      }
                                  ),

                                ],
                              ),
                            ),
                          );
                        }),
                  ):noData(height: Get.height*0.35);
              }
          )
        ],
      ),
    );
  }
}