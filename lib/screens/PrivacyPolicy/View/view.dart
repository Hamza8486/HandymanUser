

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/widgets/Colors/app_colors.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:user_apps/widgets/app_text.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isLoading=true;
  final _key = UniqueKey();
  
  @override
  Widget build(BuildContext context) {

    var size = Get.size;
    return Scaffold(
      backgroundColor: AppColor.WHITE_COLOR,
      resizeToAvoidBottomInset: false,
      body: Column(
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
                            title: "Правила сервиса",
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
          Expanded(child: Stack(
            children: [
              WebView(
                initialUrl: 'https://yamaster.kg/legal',
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading ? Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.white,
                  child: loader())
                  : Stack(),
            ],
          )
            )
        ],
      ),
    );
  }
}
