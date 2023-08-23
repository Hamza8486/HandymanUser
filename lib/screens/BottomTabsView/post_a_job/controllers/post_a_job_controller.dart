import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostAJobController extends GetxController {

  TextEditingController addressController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  RxBool status = false.obs;

  var selectDate = DateTime.now().obs;

  void toggle(bool val) {
    status.value = val;
  }

  chooseDate({required BuildContext context}) async {
    DateTime? pickDate = await showDatePicker(
        context: Get.context!,

        initialDate: selectDate.value,
        firstDate: DateTime.now(),
      locale: const Locale("ru", "RU"),
      lastDate: DateTime(2030),
    );
    if(pickDate != null && pickDate != selectDate.value){
      selectDate.value = pickDate;
    }
  }
}