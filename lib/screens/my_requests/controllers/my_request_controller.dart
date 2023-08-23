import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRequestController extends GetxController with GetSingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'All'),
    const Tab(text: 'Active'),
    const Tab(text: 'Not Active'),
  ];


  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }


}