// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/screens/Authentication/SignIn/View/sign_view.dart';
import 'package:user_apps/screens/persist_nev_bar.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';


class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() =>
      _SplashScreenViewState();
}

class _SplashScreenViewState
    extends State<SplashScreenView> {
  String userID="";

  @override
  void initState() {
    super.initState();

    HelperFunctions.getFromPreference("id").then(
            (value){
          setState(() {
            userID = value;

          });
          moveToNext();
        });



  }
  void moveToNext() {
    Timer(Duration(seconds: 3), () {
      if (userID != "") {
        Get.offAll(
          HomeScreen(currentIndex: 0),
            transition: Transition.cupertinoDialog
        );
      }
      else {
        Get.offAll(
          SignInView(),
            transition: Transition.cupertinoDialog
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.WHITE_COLOR,
      body: Column(
        children: [
          SizedBox(height: Get.height*0.47,),
          Center(
            child: Center(child: Image.asset("assets/images/splash.png",height: Get.height*0.07,)),
          ),
        ],
      ),
    );
  }
}
