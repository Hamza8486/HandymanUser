import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/images.dart';

class AllController extends GetxController {

  List<Widget> images = [
    CircleAvatar(
      backgroundImage: AssetImage(AppImages.personImage),
    ),
    CircleAvatar(
      backgroundImage: AssetImage(AppImages.personImage),
    ),
    CircleAvatar(
      backgroundImage: AssetImage(AppImages.personImage),
    ),

  ];

}