// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';
import 'package:flutter/services.dart';
import 'package:user_apps/widgets/app_text.dart';



hideKeyBoard(BuildContext context){
  FocusScope.of(context).unfocus();
}



Future<bool?> showErrorToast(String message,){
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 0,
      backgroundColor:Colors.black.withOpacity(0.8),
      textColor: Colors.red,
      fontSize: Get.height / 58,
  );
}

Future<bool?> successToast(String message,){
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 0,
      backgroundColor:Colors.black.withOpacity(0.8),
      textColor: Colors.green,


      fontSize: Get.height / 58
  );
}


