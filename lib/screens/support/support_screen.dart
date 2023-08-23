import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/support_controller.dart';


class SupportScreen extends GetView<SupportController> {
  SupportScreen({Key? key}) : super(key: key);

  final SupportController supportController = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
   return Scaffold();
  }

}