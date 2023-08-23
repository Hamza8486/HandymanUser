// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Component/update_job.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Controller/controller.dart';
import 'package:user_apps/screens/bids/components/bid_box.dart';
import 'package:user_apps/screens/bids/components/request_sheet_button.dart';
import 'package:user_apps/screens/bids/controllers/bids_controller.dart';
import 'package:user_apps/screens/chat/chat_with_provider.dart';
import 'package:user_apps/screens/provider_detail/provider_detail_screen.dart';
import 'package:user_apps/screens/provider_list/components/provider_list_box.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/AppDimensions/app_dimensions.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Dialogue/dialogue.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/Loader/loader.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_text.dart';

class BidsScreen extends StatelessWidget {
   BidsScreen({Key? key,this.data}) : super(key: key);



    var data;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var profileController = Get.put(HomeController());
    var providerController = Get.put(ProviderListController());
    whatsapp() async{
      var contact = "+996705771909";
      var androidUrl = "whatsapp://send?phone=$contact&text=Здравствуйте!";
      var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Здравствуйте!')}";

      try{
        if(Platform.isIOS){
          await launchUrl(Uri.parse(iosUrl));
        }
        else{
          await launchUrl(Uri.parse(androidUrl));
        }
      } on Exception{

      }
    }

    final BidsController bidsController = Get.put(BidsController());

    final select = Get.put(SelectTab());
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.backColor,
        body: Column(
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
                          horizontal: Get.width * 0.012,
                          vertical: Get.height * 0.018),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                        () {
                                      return GestureDetector(
                                          onTap: () {
                                            Get.put(HomeController())
                                                .updateSubId("");
                                            select.tab1.value =0;
                                            Get.back();
                                          },
                                          child: Icon(
                                            Icons.arrow_back_outlined,
                                            color: select.tab1.value ==0?AppColors.blackColor:AppColors.blackColor,
                                          ));
                                    }
                                ),
                                SizedBox(
                                  width: Get.width * 0.03,
                                ),
                                AppText(
                                    title: data.subCategoryName.isNotEmpty
                                        ? data.subCategoryName
                                        : "Category Name",
                                    size: Get.height * 0.019,
                                    overFlow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.DARK_TEXT_COLOR,
                                    fontFamily: "Poppins"),
                              ],
                            ),
                            Obx(
                              () {
                                return
                                  Get.put(SelectTab()).selectProvider.value == "0"?
                                  menuButton(context: context):SizedBox.shrink();
                              }
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: AppColor.BLACK_COLOR.withOpacity(0.2))),
                  child: SizedBox(
                      width: Get.width,
                      height: Get.height * 0.06,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: tabBusinessList(
                                text: "Отклики",
                                onTap: () {
                                  select.updateTab1(0);
                                },
                                color: !(select.tab1.value == 0)
                                    ? AppColor.WHITE_COLOR
                                    : AppColor.primaryColor,
                                color1: !(select.tab1.value == 0)
                                    ? AppColor.BLACK_COLOR
                                    : AppColor.WHITE_COLOR,
                              ),
                            ),
                            Expanded(
                              child: tabBusinessList(
                                text: "Специалисты",
                                onTap: () {
                                  select.updateTab1(1);
                                },
                                color: !(select.tab1.value == 1)
                                    ? AppColor.WHITE_COLOR
                                    : AppColor.primaryColor,
                                color1: !(select.tab1.value == 1)
                                    ? AppColor.BLACK_COLOR
                                    : AppColor.WHITE_COLOR,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            }),
            Obx(() {
              return Expanded(
                  child: select.tab1.value == 0
                      ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: data.posts.isEmpty
                          ? Center(
                          child: AppText(
                            title:
                            "Подождите откликов специалистов.\nОбычно это занимает 5-10 минут",
                            color: AppColors.blueColor,
                            fontFamily: Weights.medium,
                          ))
                          : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.zero,
                        itemCount: data.posts.length,
                        itemBuilder: (context, index) {
                          return Obx(
                                  () {
                                return BidBox(
                                  onTap:
                                  Get.put(SelectTab()).selectProvider.value == "0"?

                                      () {
                                        Get.put(HomeController()).updateUserIds(data.posts[index].providerId.toString());
                                        Get.put(HomeController()).updateJobIds(data.posts[index].jobId.toString());
                                        Get.put(HomeController()).chatData();
                                        // ApiManger().getAllNoti();

                                        Get.put(SelectTab()).updateSelectProvider("0");
                                        print("This is id ${data.posts[index].providerId.toString()}");
                                        print("This is id ${data.posts[index].jobId.toString()}");
                                        Get.put(HomeController()).allProviderData(data.posts[index].providerId.toString());
                                        Get.to(ChatWithProviderScreen(
                                          data: data,
                                          postData: data.posts[index],
                                        ),
                                        );



                                  }:() {
                                    Get.put(HomeController()).updateUserIds(data.posts[index].providerId.toString());
                                    Get.put(HomeController()).updateJobIds(data.posts[index].jobId.toString());
                                    Get.put(HomeController()).chatData();
                                    Get.put(SelectTab()).updateSelectProvider("1");
                                    // ApiManger().getAllNoti();
                                    print("This is id ${data.posts[index].providerId.toString()}");
                                    print("This is id ${data.posts[index].jobId.toString()}");
                                    Get.put(HomeController()).allProviderData(data.posts[index].providerId.toString());
                                    Get.to(ChatWithProviderScreen(
                                      data: data,
                                      postData: data.posts[index],
                                    ),
                                    );





                                  },
                                  image: data.posts[index].image==null?"":data.posts[index].image,
                                  name: data.posts[index].providerName,
                                  reviews: data.posts[index].ratingCount
                                      .toString(),
                                  rating:
                                  data.posts[index].avgRating.toString(),
                                  description: data.posts[index].description==null?"Я готов(а) выполнить работу!":data.posts[index].description,
                                  price:
                                  profileController.userId.value.isNotEmpty?
                                  data.posts[index].price:data.posts[index].price,
                                );
                              }
                          );
                        },
                      ))
                      : providerController.isProviderLoading.value
                      ? loader(height: Get.height*0.3)
                      : providerController.providerList.isNotEmpty
                      ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding:
                        EdgeInsets.only(top: Get.height * 0.01),
                        shrinkWrap: true,
                        primary: false,
                        itemCount:
                        providerController.providerList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.put(HomeController())
                                  .updateSubId(data.subId.toString());
                              providerController.updateSubId(
                                  providerController
                                      .providerList[index].id);

                              Get.to(ProviderDetailScreen(
                                data: providerController
                                    .providerList[index],
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  bottom: 10.0,
                                  top: 10),
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 24.0),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              top: 12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50.0,
                                                width: 50.0,
                                                decoration:
                                                BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColor
                                                          .primaryColor),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      100.0),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(100),
                                                  child: CachedNetworkImage(
                                                    imageUrl:providerController
                                                        .providerList[
                                                    index]
                                                        .image, fit: BoxFit.cover,
                                                    errorWidget:(context, url, error) => ClipRRect(
                                                      borderRadius: BorderRadius.circular(100),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(100),
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
                                              const SizedBox(
                                                  width: 12.0),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                children: [
                                                  const SizedBox(
                                                      height: 5.0),
                                                  Text(
                                                    "${providerController.providerList[index].firstName}",
                                                    style:
                                                    TextStyle(
                                                      fontSize:AppSizes.SIZE_17,
                                                      color: AppColors.blackColor,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: 10.0),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .star,
                                                          color: Colors
                                                              .orangeAccent,
                                                          size:
                                                          16.0),
                                                      Text(
                                                        providerController
                                                            .providerList[
                                                        index]
                                                            .avgRating
                                                            .toString(),
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          12.0,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          10.0),
                                                      Icon(
                                                          Icons
                                                              .chat_bubble,
                                                          color: AppColors
                                                              .greyColor,
                                                          size:
                                                          16.0),
                                                      SizedBox(
                                                          width:
                                                          4.0),
                                                      Text(
                                                        providerController
                                                            .providerList[
                                                        index]
                                                            .ratingCount
                                                            .toString(),
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          12.0,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                          6.0),
                                                      Text(
                                                        'отзывов',
                                                        style:
                                                        TextStyle(
                                                          fontSize:
                                                          12.0,
                                                          color: AppColors
                                                              .blackColor,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  const Divider(
                                    thickness: 0.7,
                                    color: AppColors.greyColor,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      providerController
                                          .providerList[index]
                                          .aboutMe,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AppColors.blackColor,
                                        fontFamily: Weights.semi,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.zero,
                                      itemCount: providerController
                                          .providerList[index].service.length,
                                      itemBuilder: (BuildContext context, int i) {
                                        return  Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                                          child: Row(
                                            children: [
                                              Text(providerController
                                                  .providerList[index].service[i].name,
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
                                              Text("от ${providerController.providerList[index].service[i].price.toString().split(".").first
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
                                          providerController.providerList[index].portfolio.isEmpty?SizedBox.shrink():
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              height: Get.height*0.1,
                                              child: ListView.builder(
                                                  itemCount: providerController.providerList[index].portfolio.length,
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
                                                          imageUrl:providerController.providerList[index].portfolio[ind].image, fit: BoxFit.cover,
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
                  )
                      : noData(height: Get.height*0.3));
            }),

            Container(
              color: AppColor.WHITE_COLOR,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.038,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      AppButton(
                          buttonName: "Служба поддержки",
                          buttonColor: AppColor.primaryColor,
                          buttonRadius: BorderRadius.circular(10),
                          buttonWidth: Get.width,
                          textSize: AppSizes.SIZE_14,
                          fontFamily: Weights.semi,
                          textColor: AppColor.WHITE_COLOR,
                          onTap: () {
                            whatsapp();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget leadingButton() => GestureDetector(
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
    Widget tabBusinessList({text, color, color1, onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: Get.width * 0.095, vertical: 10),
            child: Center(
              child: AppText(
                title: text,
                color: color1,
                size: AppSizes.SIZE_13,
                fontFamily: Weights.semi,
              ),
            ),
          ),
        ),
      );
    }

    Widget menuButton({required BuildContext context}) => GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.0),
              Center(
                child: Container(
                  height: 5.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              RequestSheetButton(
                onPressed: () {
                  Get.to(UpdateJobView(
                    data: data,
                  ));
                },
                titleText: 'Изменить заявку',
                leadingIcon: Icons.edit,
              ),
              RequestSheetButton(
                onPressed: () {
                  showAlertDialog(
                      context: context,
                      text: "Вы хотите удалить заявку?",
                      yesOnTap: () {
                        Get.back();
                        appLoader(context, AppColor.primaryColor);
                        ApiManger().delJobProvider(
                          jobId: data.id.toString(),
                          context: context,
                        );
                      });
                },
                titleText: 'Удалить заявку',
                leadingIcon: Icons.delete,
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
              const SizedBox(height: 24.0),
            ],
          ),
          enableDrag: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          backgroundColor: Colors.white,
          isScrollControlled: true,
        );
      },
      child: Container(
        width: 36.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.greyColor.withOpacity(0.5),
        ),
        child: const Center(
          child: Icon(Icons.more_horiz, color: Colors.white, size: 24.0),
        ),
      ),
    );
  }
