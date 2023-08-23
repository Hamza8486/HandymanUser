// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/profile/controllers/profile_controller.dart';
import 'package:user_apps/screens/bids/bids_screen.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';

class InActiveList extends StatefulWidget {
  const InActiveList({Key? key}) : super(key: key);

  @override
  State<InActiveList> createState() => _InActiveListState();
}

class _InActiveListState extends State<InActiveList> {
  final profileController = Get.put(HomeController());

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
            profileController.isReqLoading.value?Center(child: CircularProgressIndicator(
              color: AppColors.blueColor,
            )): profileController.inActiveRequestList.isNotEmpty?

            RefreshIndicator(
              onRefresh:_pullRefresh ,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: profileController.inActiveRequestList.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Get.to(BidsScreen(data: profileController.inActiveRequestList[index],));
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
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                                      child: Image.network(
                                        profileController.inActiveRequestList[index].image??"https://learnenglish.britishcouncil.org/sites/podcasts/files/styles/max_325x325/public/2021-10/RS8003_GettyImages-994576028-hig.jpg?itok=m0rIP3zI",
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, exception, stackTrace) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.asset(
                                              "assets/images/persons.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(profileController.inActiveRequestList[index].subCategoryName ??"",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children:  [
                                            Icon(Icons.location_on, color: AppColors.greyColor, size: 16.0),
                                            SizedBox(width: 8.0),
                                            Text(profileController.inActiveRequestList[index].address ??"",
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: AppColors.greyColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.redColor,
                                    ),
                                    child:  Center(
                                      child: Text(profileController.inActiveRequestList[index].postCount.toString(),
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.white,
                                        ),
                                      ),
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
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(profileController.inActiveRequestList[index].description ??"",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            profileController.inActiveRequestList[index].budget == ""?Container():
                            const SizedBox(height: 8.0),

                            profileController.inActiveRequestList[index].budget == ""?Container():
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
                                  Text(profileController.inActiveRequestList[index].budget ??"0",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700,
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
                              padding:  EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [

                                  Text('Откликов',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: AppColors.greyColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),

                                  Icon(Icons.arrow_forward_ios, color: AppColors.greyColor, size: 16.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ):Center(child: AppText(title: "Нет данных",
              color: AppColors.blackColor,
              fontFamily: Weights.semi,

            ));
        }
    );
  }
}
