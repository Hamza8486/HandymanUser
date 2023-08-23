// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/portfolio_detail.dart';
import 'package:user_apps/screens/BottomTabsView/profile/controllers/profile_controller.dart';
import 'package:user_apps/screens/provider_detail/components/review_box.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';




class MessageDetailScreen extends StatelessWidget {
  MessageDetailScreen({Key? key, this.data}) : super(key: key);

  var data;
  final providerListController = Get.put(ProviderListController());


  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    final double height = MediaQuery
        .of(context)
        .size
        .height;
    final double width = MediaQuery
        .of(context)
        .size
        .width;
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
                            title: "Профиль специалиста",
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 36.0),
                  profileImageRow(height,context),

                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('УСЛУГИ',
                      style: TextStyle(
                        fontSize: Get.height*0.021,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  servicePricingBox(width),


                  const SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text('ОТЗЫВЫ: ',
                      style: TextStyle(
                        fontSize: Get.height*0.021,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                      ),
                    ),
                  ),


                  const SizedBox(height: 12.0),

                  data.ratings.isEmpty?     Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: Text("Пока нет отзывов",
                        style:  TextStyle(
                          fontSize: Get.height*0.018,
                          fontFamily: Weights.regular,
                          color: AppColors.blackColor,

                        ),

                      ),
                    ),
                  ):
                  // Container(
                  //   width: width,
                  //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   padding: const EdgeInsets.only(top: 10.0, bottom: 24.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(16.0),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: AppColors.greyColor.withOpacity(0.2),
                  //         blurRadius: 7.0,
                  //         offset: const Offset(0.0, 7.0),
                  //       ),
                  //     ],
                  //   ),
                  //   child: ListView.builder(
                  //       padding: EdgeInsets.zero,
                  //       itemCount: data.ratings.length,
                  //       shrinkWrap: true,
                  //       physics: const NeverScrollableScrollPhysics(),
                  //       itemBuilder: (context, index) {
                  //         return ReviewBox(data: data.ratings[index],);
                  //       }
                  //   ),
                  // ),

                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('О СЕБЕ',
                      style: TextStyle(
                        fontSize: Get.height*0.021,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                      ),

                    ),
                  ),
                  const SizedBox(height: 12.0),
                  aboutMeBox(),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text("ФОТО РАБОТ",
                      style:  TextStyle(
                        fontSize: Get.height*0.021,
                        fontFamily: Weights.semi,
                        color: AppColors.blackColor,

                      ),


                    ),
                  ),
                  // data.portfolio.isEmpty?     Center(
                  //   child: Text("No Images",
                  //     style:  TextStyle(
                  //       fontSize: Get.height*0.018,
                  //       fontFamily: Weights.regular,
                  //       color: AppColors.blackColor,
                  //
                  //     ),
                  //
                  //   ),
                  // ):


                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 24),
                  //   child: SizedBox(
                  //     height: Get.height*0.15,
                  //     child: ListView.builder(
                  //         itemCount: data.portfolio.length,
                  //         padding: EdgeInsets.zero,
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           return GestureDetector(
                  //             onTap: (){
                  //               Get.to(PortfolioDetail(data:data ,));
                  //             },
                  //             child: Container(
                  //
                  //
                  //               margin: EdgeInsets.symmetric(horizontal: index == 0?0:Get.width*0.02,vertical: 10),
                  //               width: Get.height*0.14,
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(color: AppColor.primaryColor,width: 2),
                  //                 borderRadius: BorderRadius.circular(10),
                  //
                  //                 image: DecorationImage(
                  //                     fit: BoxFit.cover,
                  //                     image: NetworkImage(
                  //                       data.portfolio[index].image,
                  //                     )),
                  //
                  //               ),
                  //
                  //             ),
                  //           );
                  //         }),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget leadingButton() =>
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 36.0,
          width: 36.0,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          child: const Center(
            child: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
          ),
        ),
      );


  Widget profileImageRow(height,BuildContext context) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50.0,
              width: 50.0,
              margin: const EdgeInsets.only(top: 32.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Center(
                child: Icon(Icons.verified_user_sharp, color: Colors.green),
              ),
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(data.image),
                ),
                const SizedBox(height: 16.0),
                Text("${data.providerName}",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: AppColors.blackColor,
                    fontFamily: Weights.semi,

                  ),
                ),
                const SizedBox(height: 5.0),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 18.0, color: Colors.orangeAccent),
                    Text("${data.avgRating.toString()}.0",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Icon(CupertinoIcons.chat_bubble, size: 18.0,
                        color: AppColors.greyColor),
                    SizedBox(width: 7),
                    Text(data.ratingCount.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // GestureDetector(
            //   onTap: (){
            //     providerListController.updateStatus("1");
            //     ApiManger.favResponse(
            //         context: context,
            //         providerId: providerListController.subId.value.toString(),
            //         id: profileController.userId.value.toString(),
            //         status:providerListController.status.value
            //
            //     );
            //   },
            //   child: Container(
            //     height: 50.0,
            //     width: 50.0,
            //     margin: const EdgeInsets.only(top: 32.0),
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.white,
            //     ),
            //     child: Center(
            //       child: Obx(() =>
            //       providerListController.status.value == "1"?
            //       const Icon(
            //           Icons.star, color: AppColors.blueColor, size: 32.0)
            //           : const Icon(
            //           Icons.star_border_rounded, color: AppColors.greyColor,
            //           size: 32.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  Widget aboutMeBox() =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              blurRadius: 7.0,
              offset: const Offset(0.0, 7.0),
            ),
          ],
        ),
        child: Text(data.description,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.0,

            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      );

  Widget servicePricingBox(width) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.2),
            blurRadius: 7.0,
            offset: const Offset(0.0, 7.0),
          ),
        ],
      ),
      child: ListView.builder(
          itemCount: data.services.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.services[index].name,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.blackColor,
                            fontFamily: Weights.semi,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(data.services[index].description,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AppColors.blackColor.withOpacity(0.5),
                            fontFamily: Weights.regular,
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),

                  SizedBox()
                ],
              ),
            );
          }),
    );
  }
}