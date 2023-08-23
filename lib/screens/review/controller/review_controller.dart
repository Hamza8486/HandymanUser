import 'package:get/get.dart';

class ReviewController extends GetxController {


  var rate = 0.obs;

  updateRate(value){
    rate.value = value;
    update();
  }

}