// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/components/portfolio_detail.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/provider_detail/components/review_box.dart';
import 'package:user_apps/screens/provider_list/components/provider_list_box.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_text.dart';



class FavouriteDetailScreen extends StatefulWidget {
  FavouriteDetailScreen({Key? key, this.data}) : super(key: key);

  var data;

  @override
  State<FavouriteDetailScreen> createState() => _FavouriteDetailScreenState();
}

class _FavouriteDetailScreenState extends State<FavouriteDetailScreen> {
  final providerListController = Get.put(ProviderListController());
  whatsapp() async{
    var contact = "+996705771909";
    var androidUrl = "whatsapp://send?phone=$contact&text=Здраствуйте!";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Здраствуйте!')}";

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


  Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw("Cannot dial");
    }
  }

  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }
  final profileController = Get.put(HomeController());

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.put(HomeController()).updateProvider("");
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
                              size: Get.height * 0.018,
                              overFlow: TextOverflow.ellipsis,
                              color: AppColor.DARK_TEXT_COLOR,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,),
                          ],
                        ),
                      SizedBox()
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
                    child: Text('О СЕБЕ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                      ),

                    ),
                  ),
                  const SizedBox(height: 12.0),
                  aboutMeBox(),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('УСЛУГИ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  servicePricingBox(width),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("ФОТО РАБОТ",
                      style:  TextStyle(
                        fontSize: Get.height*0.017,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,

                      ),


                    ),
                  ),
                  widget.data.portfolio.isEmpty?     Center(
                    child: Text("Пока нет фото",
                      style:  TextStyle(
                        fontSize: Get.height*0.018,
                        fontFamily: Weights.regular,
                        color: AppColors.blackColor,

                      ),

                    ),
                  ):


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      height: Get.height*0.13,
                      child: ListView.builder(
                          itemCount: widget.data.portfolio.length,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (){
                                Get.to(PortfolioDetail(data:widget.data.portfolio[index].image,));
                              },
                              child: Container(


                                margin: EdgeInsets.symmetric(horizontal: index == 0?0:Get.width*0.02,vertical: 10),
                                width: Get.height*0.14,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.primaryColor,width: 2),
                                  borderRadius: BorderRadius.circular(10),

                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                       widget.data.portfolio[index].image,
                                      )),

                                ),

                              ),
                            );
                          }),
                    ),
                  ),


                  const SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('ОТЗЫВЫ',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  widget.data.ratings.isEmpty?Center(
                    child: Text('Пока нет отзывов',
                      style: TextStyle(
                        fontSize: Get.height*0.018,
                        fontFamily: Weights.regular,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ):
                  Container(
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
                        itemCount: widget.data.ratings.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ReviewBox(data: widget.data.ratings[index],);
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(buttonName: "Позвонить", buttonColor: AppColors.blueColor, textColor: AppColor.WHITE_COLOR, onTap:

                      ()async{
                        await FlutterPhoneDirectCaller.callNumber(widget.data?.phoneNo);

                  },
                    buttonRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: Get.width*0.03,),
                Expanded(
                  child: AppButton(buttonName: "Заявка", buttonColor: Colors.green, textColor: AppColor.WHITE_COLOR, onTap: (){
                    whatsapp();
                  },
                    buttonRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Column(
              children: [
                Container(
                  height: Get.height*0.15,
                  width: Get.height*0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: AppColor.primaryColor,width: 1.2)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: widget.data.image , fit: BoxFit.cover,
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

                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text("${widget.data.firstName},",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: AppColors.blackColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                    SizedBox(width: Get.width*0.02,),
                    Text("${calculateAge(DateTime.parse(widget.data.age))} лет",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, size: 22.0, color: AppColor.primaryColor),
                    SizedBox(width: 7),
                    Text("Паспорт",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: AppColors.blackColor,
                        fontFamily: Weights.regular,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Icon(Icons.star, size: 18.0, color: Colors.orangeAccent,),
                    Text("${widget.data.avgRating.toString()}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Icon(CupertinoIcons.chat_bubble, size: 18.0,
                        color: AppColors.greyColor),
                    SizedBox(width: 7),
                    Text(widget.data.ratingCount.toString(),
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
            SizedBox()
          ],
        ),
      );

  Widget aboutMeBox() =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.all(17.0),
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
        child: Text(widget.data.aboutMe,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 15.0,
            color: AppColors.blackColor,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
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
          itemCount: widget.data.service.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.data.service[index].name??"",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.blackColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: Get.width*0.02,),
                  Expanded(
                    child: MySeparator(color: AppColors.blackColor.withOpacity(0.6),),
                  ),
                  SizedBox(width: Get.width*0.03,),
                  Text("${widget.data.service[index].price.toString().split(".").first} сом",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.blackColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );


            /*Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            Text(data.services[index].name,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.blackColor,
                                fontFamily: Weights.semi,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
            );*/
          }),
    );
  }
}