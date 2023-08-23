import 'package:get/get.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/selectProvider.dart';

class SelectTab extends GetxController {
  var tab = 0.obs;
  var tab1 = 0.obs;
  var timer = 0.obs;
  var selectProvider = "".obs;
  updateSelectProvider(val){
    selectProvider.value = val;
    update();

  }

  SelectProviderModel  ?selectProviderModel;
  var text = "Deal Of The Day ".obs;
  RxBool isActive = true.obs;

  updateTab(val) {
    tab.value = val;

    update();
  }
  updateTab1(val) {
    tab1.value = val;

    update();
  }
  var isLoading = false.obs;

  updateTime(val) {
    timer.value = val;

    update();
  }

  toggleActiveStatus() {
    isActive.toggle();
    update();
  }



}
