// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Controller/controller.dart';
import 'package:user_apps/screens/bids/bids_screen.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/screens/review/submit_review_screen.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_button.dart';

class ActiveList extends StatefulWidget {
  ActiveList({Key? key}) : super(key: key);

  @override
  State<ActiveList> createState() => _ActiveListState();
}

class _ActiveListState extends State<ActiveList> {
  final profileController = Get.put(HomeController());
  var providerListController = Get.put(ProviderListController());

  Future<void> _pullRefresh() async {
    setState(() {
      profileController.allRequestData(profileController.userId.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
            () {
          return
            profileController.isReqLoading.value?loader(height: Get.height*0.3): profileController.activeRequestList.isNotEmpty?

            RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: profileController.activeRequestList.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        print(profileController.activeRequestList[index].subId.toString());
                        print("Hamza");

                        Get.put(HomeController())
                            .updateSubId("");
                        Get.put(SelectTab())
                            .updateSelectProvider(profileController.activeRequestList[index].selectProvider==null?"0":"1");
                        providerListController.providerData(
                            subCatId:
                            profileController.activeRequestList[index].subId.toString());
                        ApiManger().getAllNoti(job: profileController.activeRequestList[index].id);
                        Get.to(BidsScreen(data: profileController.activeRequestList[index],));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor.withOpacity(0.2),
                              blurRadius: 3.0,
                              offset: const Offset(5.0, 0.0),
                            ),
                            BoxShadow(
                              color: AppColors.greyColor.withOpacity(0.2),
                              blurRadius: 3.0,
                              offset: const Offset(0.0, 5.0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: profileController.activeRequestList[index].image==null?"":
                                        profileController.activeRequestList[index].image??""  , fit: BoxFit.cover,
                                        errorWidget:(context, url, error) => ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.asset(
                                            'assets/images/person.png',
                                            fit: BoxFit.cover,
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

                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(

                                              width:
                                              Get.width*0.55,
                                              child: Text(profileController.activeRequestList[index].subCategoryName.isEmpty? "on moderation":profileController.activeRequestList[index].subCategoryName,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,

                                                  fontWeight: FontWeight.w700,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            (Get.put(HomeController())
                                                .notificationList
                                                .where((element) {
                                              if(element.jobId == profileController.activeRequestList[index].id)
                                              {
                                                Get.put(HomeController()).updateRead(element.isRead==null?"":"read");
                                              }


                                              return element.jobId == profileController.activeRequestList[index].id;
                                            })
                                                .toList()).isNotEmpty?


                                            Container(
                                              height: 8.0,
                                              width: 8.0,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.redColor,
                                              ),

                                            ):SizedBox.shrink(),
                                            // Container(
                                            //   height: 20.0,
                                            //   width: 20.0,
                                            //   decoration: const BoxDecoration(
                                            //     shape: BoxShape.circle,
                                            //     color: AppColors.redColor,
                                            //   ),
                                            //   child:  Center(
                                            //     child: Text(profileController.activeRequestList[index].postCount.toString(),
                                            //       style: TextStyle(
                                            //         fontSize: 10.0,
                                            //         color: Colors.white,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),

                                        SizedBox(height: 10.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Icon(Icons.location_on, color: AppColors.greyColor, size: 16.0),
                                            SizedBox(width: 8.0),
                                            Expanded(
                                              child: Text(profileController.activeRequestList[index].address ??"",
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  overflow: TextOverflow.ellipsis,

                                                  color: AppColors.blackColor,
                                                  fontFamily: Weights.medium,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Divider(
                              color: AppColors.greyColor.withOpacity(0.6),
                              thickness: 1.0,
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                              child: Text( profileController.activeRequestList[index].description==null?"":
                              profileController.activeRequestList[index].description ??"",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,

                                    fontFamily: Weights.regular
                                ),
                              ),
                            ),

                            const SizedBox(height: 8.0),
                            profileController.activeRequestList[index].budget == null?SizedBox.shrink():
                            Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Row(
                                children: [
                                  Text("Budget:   ",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text("${profileController.activeRequestList[index].budget.toString()} сом",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            profileController.activeRequestList[index].selectProvider==null?SizedBox.shrink():
                            SizedBox(height: 20.0),
                            profileController.activeRequestList[index].selectProvider==null?SizedBox.shrink():
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: Get.width*0.06),
                              child: AppButton(buttonName: "Завершить", buttonColor: Colors.green, textColor:Colors.white,
                                onTap: (){
                                  Get.to(SubmitReviewScreen(
                                    proId: profileController.activeRequestList[index].providerId.toString()??"",
                                    jobId: profileController.activeRequestList[index].id.toString(),
                                  ));
                                },
                                textSize: Get.height*0.017,
                                buttonHeight: Get.height*0.05,
                                buttonWidth: Get.width,
                                buttonRadius: BorderRadius.circular(10),

                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ): noData();
        }
    );
  }
}
