import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderDetailController extends GetxController {

  RxBool isFav = false.obs;

  void isFavorite() {
    isFav.value = !isFav.value;
  }
  TextEditingController addressController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

}