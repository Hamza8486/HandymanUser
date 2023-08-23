// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/Authentication/Controller/controller.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/SnackBar/snack_bar.dart';
import 'package:user_apps/widgets/app_button.dart';
import 'package:user_apps/widgets/app_dimensions.dart';
import 'package:user_apps/widgets/app_text.dart';


import '../../../widgets/Loader/loader.dart';


class RegisterView extends StatefulWidget {
   RegisterView({Key? key,this.phone}) : super(key: key);
  var phone;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {





  TextEditingController fNameController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  bool isUserVisible = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var lat;
  var lng;
  var address;
  String ? token;
  void getToken() async{
    await Firebase.initializeApp();
     token = await FirebaseMessaging.instance.getToken();

    HelperFunctions.saveInPreference("token", token!);
    print("token");
    print(token);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.cityData();
    getToken();
    HelperFunctions.getFromPreference("tokem").then(
            (value){
          setState(() {
            token = value;
            phoneController.text = widget.phone.toString();
          });
          print(token);
          print(token);
          print(token);


        });


  }

  final homeController = Get.put(AuthController());

  var _selectedValue;


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    var size = Get.size;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Center(
              child: AppText(
                //title: "Create an account",
                title: "Создать аккаунт",
                color: AppColor.BLACK_COLOR,
                size: AppDimensions.FONT_SIZE_20,
                fontFamily: Weights.semi,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: size.height * 0.004,
            ),
            Center(
              child: AppText(
                //title: "Enter information to complete profile",
                title: "Введите информацию для заполнения профиля",
                color: AppColor.BLACK_COLOR,
                size: AppDimensions.FONT_SIZE_14,
                fontFamily: Weights.regular,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    Text(
                      //'Full Name',
                      'Имя',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.blackColor,
                        fontFamily: Weights.semi,
                        fontWeight: FontWeight.w700
                      ),
                    ),



                    TextFormField(
                      style: TextStyle(
                        fontSize: AppDimensions.FONT_SIZE_15,
                        color: AppColor.DARK_TEXT_COLOR,
                        fontFamily: Weights.medium,
                      ),
                      controller: fNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.person,
                              color: AppColors.blueColor),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,
                        ),
                        hintText: 'Введите ваше имя',
                        //hintText: 'Enter your Name',
                        hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),


                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      'Город',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.blackColor,
                          fontFamily: Weights.semi,
                          fontWeight: FontWeight.w700
                      ),
                    ),


                    Obx(
                      () {
                        return DropdownButtonFormField(
                            decoration: InputDecoration(



                              contentPadding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.018,
                                  horizontal:homeController.cityList.isEmpty?10: 10),



                            ),
                            value: _selectedValue,
                            style: TextStyle(color: AppColor.DARK_TEXT_COLOR,fontFamily: Weights.medium),
                            hint: Text(
                              //'Select City',
                              'Выберите город',
                              style: TextStyle(
                                fontSize: AppDimensions.FONT_SIZE_15,
                                color: AppColor.DARK_TEXT_COLOR,
                                fontFamily: Weights.regular,
                              ),
                            ),
                            isExpanded: true,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            },
                            items:nameDataList(dataList: homeController.cityList)



                        );
                      }
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      //'Mobile Number',
                      'Номер мобильного телефона',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,

                          fontFamily: Weights.semi,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      readOnly: true,
                      style: TextStyle(
                        fontSize: AppDimensions.FONT_SIZE_15,
                        color: AppColor.DARK_TEXT_COLOR,
                        fontFamily: Weights.medium,
                      ),
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.phone_android_outlined,
                              color: AppColors.blueColor),
                        ),
                        contentPadding: EdgeInsets.only(top: 16.0, left: 0.0),
                        prefixStyle: TextStyle(
                          fontSize: 15.0,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.07,
                    ),
                    AppButton(
                      buttonWidth: size.width,

                      buttonRadius: BorderRadius.circular(25),
                      fontFamily: Weights.semi,
                      textSize: size.height * 0.02,
                      buttonName: "Продолжить",
                      buttonColor: AppColor.primaryColor,

                      textColor: AppColor.WHITE_COLOR,
                      onTap: () {
                        if (validate()) {
                          appLoader(context, AppColor.primaryColor);


                          ApiManger.registerResponse(context: context,
                              password: passwordController.text,
                              phone: widget.phone,
                              first: fNameController.text,
                              city: _selectedValue.toString(),
                              token: token

                          );
                        }
                      },

                    ),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }


  List<DropdownMenuItem<int>> nameDataList({var dataList}) {
    List<DropdownMenuItem<int>> outputList = [];
    for (int i = 0; i < dataList.length; i++) {
      outputList.add(DropdownMenuItem<int>(
          value: dataList[i].id,
          child: AppText(
            title: dataList[i].name,
            size: AppDimensions.FONT_SIZE_15,
            color: AppColor.DARK_TEXT_COLOR,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          )));
    }
    return outputList;
  }
  bool validate() {

    if (fNameController.text.isEmpty) {
      showErrorToast( 'Требуется полное имя');

      return false;
    }
    if (_selectedValue == null) {
      showErrorToast( 'Выберите город');

      return false;
    }



    return true;
  }
}