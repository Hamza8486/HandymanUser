// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/categories.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/search_screen.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/sub_category.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/update_location.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/sub_controller.dart';
import 'package:user_apps/screens/BottomTabsView/support_section/controllers/support_section_controller.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/app_text.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final providerController = Get.put(ProviderListController());

  final homeController = Get.put(HomeController());
  final subCatController = Get.put(SubController());
  final fieldController = TextEditingController();
  final supportSectionController = Get.put(SupportSectionController());

  Future<void> _pullRefresh() async {
    setState(() {
      homeController.homeData1();
      homeController.homeData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // homeController.homeData1();
    // homeController.homeData();
    // homeController.allPopularData();
  }

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
        backgroundColor: AppColors.backColor,
        body: Obx(() {
          return Column(
            children: [
              Material(
                color: homeController.catList.isNotEmpty
                    ? AppColor.WHITE_COLOR
                    : AppColor.WHITE_COLOR,
                elevation: 1,
                child: SizedBox(
                  width: size.width,
                  height: size.height / 8.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.018),
                        child: Row(
                          children: [
                            InkWell(
                                child: Image.asset(
                              "assets/images/location.png",
                              height: size.height * 0.035,
                              color: AppColors.blackColor,
                            )),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    context: context,
                                    builder: (context) => GetAddressView());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    title: homeController.address.value,
                                    size: size.height * 0.018,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis,
                                    color: AppColor.DARK_TEXT_COLOR,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _pullRefresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03),
                            decoration: BoxDecoration(
                                color: AppColor.WHITE_COLOR,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: TextField(
                                onTap: () {
                                  subCatController.searchUpdate(
                                      searchKeyword: "");
                                  homeController.serviceJobData(
                                      id: "", sub: "");

                                  Get.to(SearchScreenView(),
                                      transition: Transition.rightToLeft);
                                },
                                maxLines: 1,
                                readOnly: true,
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
                          const SizedBox(height: 24.0),
                          SizedBox(
                            height: Get.height * 0.11,
                            width: Get.width,
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.bannerList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.03,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: homeController
                                              .bannerList[index].image,
                                          fit: BoxFit.cover,
                                          width: Get.width * 0.9,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                            color: AppColors.blueColor,
                                          )),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                child: Text(
                                  'Популярное',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.021,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.02),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                child: AllCategories(),
                              ),
                              SizedBox(height: Get.height * 0.025),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                child: Text(
                                  'Категории',
                                  style: TextStyle(
                                      fontSize: Get.height * 0.021,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.015),
                              Obx(() {
                                return homeController.catLoading.value
                                    ? loader(height: Get.height * 0.15)
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.03),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            padding: homeController
                                                    .catList.isNotEmpty
                                                ? EdgeInsets.zero
                                                : EdgeInsets.zero,
                                            itemCount:
                                                homeController.catList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      SubCategoryView(
                                                        data: homeController
                                                            .catList[index],
                                                      ),
                                                      transition: Transition
                                                          .rightToLeft);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  child: Column(
                                                    children: [
                                                      Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.004,
                                                      ),
                                                      Container(
                                                        color:
                                                            Colors.transparent,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          border: Border
                                                                              .all(
                                                                            color:
                                                                                AppColor.primaryColor,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(100)),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    child: Image
                                                                        .network(
                                                                      homeController
                                                                              .catList[index]
                                                                              .image ??
                                                                          "",
                                                                      height: Get
                                                                              .height *
                                                                          0.05,
                                                                      width: Get
                                                                              .height *
                                                                          0.05,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                          exception,
                                                                          stackTrace) {
                                                                        return ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100),
                                                                          child:
                                                                              Image.asset(
                                                                            height:
                                                                                Get.height * 0.05,
                                                                            width:
                                                                                Get.height * 0.05,
                                                                            "assets/images/1 - category.png",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.03,
                                                                ),
                                                                Text(
                                                                  homeController
                                                                          .catList[
                                                                              index]
                                                                          .name ??
                                                                      "",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        Get.height *
                                                                            0.019,
                                                                    color: AppColors
                                                                        .blackColor,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              color:
                                                                  Colors.grey,
                                                              size: Get.height *
                                                                  0.02,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                              })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
