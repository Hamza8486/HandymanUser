import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';

import 'active/active_screen.dart';
import 'all/all_screen.dart';
import 'controllers/my_request_controller.dart';
import 'not_active/not_active_screen.dart';


class MyRequestScreen extends GetView<MyRequestController> {
  MyRequestScreen({Key? key}) : super(key: key);

  final MyRequestController myRequestController = Get.put(MyRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        toolbarHeight: 80.0,
        leading: SizedBox(),
        elevation: 0.0,
        titleSpacing: 0.0,
        title: appBarTitle(),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.delete, color: AppColors.greyColor),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            controller: myRequestController.controller,
            tabs: myRequestController.myTabs,
            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            indicatorPadding: const EdgeInsets.symmetric(vertical: 5.0),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: AppColors.blueColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.greyColor,
            labelPadding: const EdgeInsets.symmetric(horizontal: 28.0),
            labelStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: myRequestController.controller,
              children: myRequestController.myTabs.map((Tab tab) {
                final String label = tab.text!.toLowerCase();
                return label == 'all'
                    ? AllScreen()
                    : label == 'active'
                    ? ActiveScreen()
                    : NotActiveScreen();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarTitle() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text('Заявки и чаты',
        style: TextStyle(
          fontSize: 22.0,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: 8.0),
      Text('7 Requests',
        style: TextStyle(
          fontSize: 15.0,
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );

}