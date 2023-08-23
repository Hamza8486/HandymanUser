import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

import 'components/subcategory_box.dart';
import 'controllers/all_controller.dart';

class AllScreen extends GetView<AllController> {
  AllScreen({Key? key}) : super(key: key);

  final AllController allController = Get.put(AllController());

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: AppColors.backColor,
     body: ListView.builder(
       padding: const EdgeInsets.symmetric(vertical: 24.0),
         itemCount: 5,
         itemBuilder: (context, index){
           return SubCategoryBox();
         }),
   );
  }

}