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

class All extends StatefulWidget {
   All({Key? key}) : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
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
            profileController.isReqLoading.value?loader(height: Get.height*0.3): profileController.allRequestList.isNotEmpty?

            RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Obx(
                () {
                  return ListView.builder(
                      padding:  EdgeInsets.symmetric(vertical:
                      profileController.allRequestList.isNotEmpty?10.0:

                      10.0),
                      itemCount: profileController.allRequestList.length,
                      itemBuilder: (context, index){
                        return
                          profileController.allRequestList[index].status == "2"?
                              SizedBox.shrink():

                          GestureDetector(
                          onTap:
                          profileController.allRequestList[index].status == "2"?(){}:

                              (){
                                providerListController.providerData(
                                    subCatId:
                                    profileController.allRequestList[index].subId.toString());
                                print(profileController.allRequestList[index].subId.toString());
                                Get.put(HomeController())
                                    .updateSubId("");
                                Get.put(SelectTab())
                                    .updateSelectProvider(profileController.allRequestList[index].selectProvider==null?"0":"1");
                                ApiManger().getAllNoti(job: profileController.allRequestList[index].id);
                            Get.to(


                                BidsScreen(data: profileController.allRequestList[index],));
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
                                            imageUrl:
                                            profileController.allRequestList[index].image==null?"":
                                            profileController.allRequestList[index].image??"" , fit: BoxFit.cover,
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



                                      SizedBox(width: 10.0),
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
                                                  child: Text(profileController.allRequestList[index].subCategoryName.isEmpty? "На модерации":profileController.allRequestList[index].subCategoryName,
                                                    maxLines: 1
                                                    ,
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      overflow: TextOverflow.ellipsis,

                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                (Get.put(HomeController())
                                                    .notificationList
                                                    .where((element) {
                                                  if(element.jobId == profileController.allRequestList[index].id)
                                                  {
                                                    Get.put(HomeController()).updateRead(element.isRead==null?"":"read");
                                                  }


                                                  return element.jobId == profileController.allRequestList[index].id;
                                                })
                                                    .toList()).isNotEmpty?


                                                Container(
                                                  height: 10.0,
                                                  width: 10.0,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.redColor,
                                                  ),

                                                ):SizedBox.shrink(),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                                Icon(Icons.location_on, color: AppColors.greyColor, size: 16.0),
                                                SizedBox(width: 8.0),
                                                Expanded(
                                                  child: Text(profileController.allRequestList[index].address ??"",
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
                                  child: Text(
                                    profileController.allRequestList[index].description==null?"":
                                    profileController.allRequestList[index].description ??"",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,

                                     fontFamily: Weights.regular
                                    ),
                                  ),
                                ),
                                profileController.allRequestList[index].status == "2"?Container():
                                SizedBox(height: 10.0),
                                profileController.allRequestList[index].status == "2"?Container():
                                profileController.allRequestList[index].status == "2"?Container():
                                profileController.allRequestList[index].budget==null?SizedBox.shrink():
                                Padding(
                                  padding: EdgeInsets.only(left: 24.0),
                                  child: Row(
                                    children: [
                                      Text("Бюджет:   ",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text("${profileController.allRequestList[index].budget.toString()} сом",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                profileController.allRequestList[index].selectProvider==null?SizedBox.shrink():
                                SizedBox(height: 20.0),
                                profileController.allRequestList[index].selectProvider==null?SizedBox.shrink():
                                    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: Get.width*0.06),
                                      child: AppButton(buttonName: "Завершить", buttonColor: Colors.green, textColor:Colors.white,
                                        onTap: (){
                                          Get.to(SubmitReviewScreen(
                                            proId: profileController.allRequestList[index].providerId.toString()??"",
                                            jobId: profileController.allRequestList[index].id.toString(),
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
                      });
                }
              ),
            ):
            noData();
        }
    );
  }
}
