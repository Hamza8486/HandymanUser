import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

import '../all/components/subcategory_box.dart';
import 'controllers/not_active_controller.dart';

class NotActiveScreen extends GetView<NotActiveController> {
  NotActiveScreen({Key? key}) : super(key: key);

  final NotActiveController notActiveController = Get.put(NotActiveController());

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