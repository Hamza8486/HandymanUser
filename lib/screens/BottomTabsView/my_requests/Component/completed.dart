// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';

class CompleteList extends StatelessWidget {
  CompleteList({Key? key}) : super(key: key);
  final profileController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return profileController.isReqLoading.value
          ? loader(height: Get.height * 0.3)
          : profileController.compRequestList.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: profileController.compRequestList.length,
                  itemBuilder: (context, index) {
                    DateTime time = DateTime.parse(
                      profileController.compRequestList[index].date,
                    );
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 24.0, right: 24.0, bottom: 16.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                                      imageUrl: profileController
                                              .compRequestList[index].image ??
                                          "",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        profileController
                                                .profileMOdel?.firstName ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.location_on,
                                              color: AppColors.greyColor,
                                              size: 16.0),
                                          SizedBox(width: 8.0),
                                          Expanded(
                                            child: Text(
                                              profileController
                                                  .compRequestList[index]
                                                  .address ??"",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: AppColors.greyColor,
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
                          for (int i = 0;
                              i <
                                  profileController
                                      .compRequestList[index].posts.length;
                              i++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Специалист : ",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.grey,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        profileController.compRequestList[index]
                                            .posts[i].providerName ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height*0.013,),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Бюджет : ",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.grey,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${profileController.compRequestList[index]
                                            .posts[i].price.toString() ??""} сом",


                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Get.height*0.013,),
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Создан : ",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.grey,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd MMM yyyy').format(time),
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            )
                        ],
                      ),
                    );
                  })
              : noData();
    });
  }
}
