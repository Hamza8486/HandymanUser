// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColor {

  static const apiKey = "AIzaSyBfd3J1uwYr-qhOrk8dke78tE8hMPvStXc";
  static Color WHITE_COLOR = const Color(0xffFFFFFF);
  static Color BLACK_COLOR = const Color(0xff000000);
  static Color DARK_TEXT_COLOR = const Color(0xff000000);
  static Color GREY_COLOR = const Color.fromARGB(255, 138, 142, 150);
  static Color DARK_GREY_COLOR = const Color(0xFF54545A);
  static Color LIGHT_GREY_COLOR = const Color(0xFF98a1ab);
  static Color Border_COLOR = const Color(0xFFBFA5A4);
  static Color primaryColor = const Color(0xff3d89bf);
  static Color TRANSPARENT_COLOR = Colors.transparent;
  static Color categoryBgColor =
      Get.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFFb2b8bd);

  static Color greyColor =
      Get.isDarkMode ? Color(0xFFb2b8bd) : Color(0xFFE4EAEF);

  static Color timeColor =
      Get.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFFE4EAEF);

  static Color darkColor =
      Get.isDarkMode ? Color(0xFF4d5054) : Color(0xFF25282B);

  static Color cardBgColor =
      Get.isDarkMode ? Color(0xFFFFFFFF).withOpacity(0.05) : Color(0xFFFFFFFF);

  static Color textColor =
      Get.isDarkMode ? Color(0xFFFFFFFF).withOpacity(0.6) : Color(0xFF1F1F1F);
  static Color textbuttonColor =
      Get.isDarkMode ? Color(0xFF1F1F1F) : Color(0xFFFFFFFF).withOpacity(0.6);
  static Color hintColor =
      Get.isDarkMode ? Color(0xFF98a1ab) : Color(0xFF7A7A7A);
  static Color backgroundColor =
      Get.isDarkMode ? Color(0xFF4d5054) : Color(0xFFFAFAFA);
  static Color greyLightColor =
      Get.isDarkMode ? Color(0xFFb2b8bd) : Color(0xFF98a1ab);
  static Color yellow = Get.isDarkMode ? Color(0xFF916129) : Color(0xFFFFAA47);

  static Color orderColor =
      Get.isDarkMode ? Color(0xFF4d5054) : Color(0xFFE4EAEF).withOpacity(0.9);
}
