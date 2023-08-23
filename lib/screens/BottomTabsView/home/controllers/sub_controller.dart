// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/search_sub_category.dart';

class SubController extends GetxController {


  var isLoading = false.obs;
  var isNewLoading = false.obs;
  var isSubLoading = false.obs;
  var searchList = [].obs;
  var subList = [].obs;
  var subSubList = [].obs;

  var servicesList=<Services>[].obs;
  var subCatsList=<SubCategories>[].obs;




  @override
  void onInit() {
    // TODO: implement onInit
    searchSubCat(searchKeyword: "all");
    searchUpdate(searchKeyword:"");
    super.onInit();
  }



  searchUpdate({var searchKeyword}) async {
    try {
      isNewLoading(true);
      update();

      var searchData =
      await ApiManger.subCategoryRes(category: searchKeyword);
      if (searchData != null) {
        servicesList.value = searchData.data?.services as dynamic;
        subCatsList.value = searchData.data?.subCategories as dynamic;
        print(searchList);
      } else {
        isNewLoading(false);
        update();
      }
    } catch (e) {
      isNewLoading(false);
      update();
      print(e.toString());
    } finally {
      isNewLoading(false);
      update();
    }
  }





  searchSubCat({var searchKeyword}) async {
    try {
      isLoading(true);

      var searchData =
      await ApiManger.subCatRes(category: searchKeyword);
      if (searchData != null) {
        subList.value = searchData.data as dynamic;
        print(searchList);
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }




  catSubCat({var searchKeyword}) async {
    try {
      isSubLoading(true);
      update();

      var searchData =
      await ApiManger.subCatRes(category: searchKeyword);
      if (searchData != null) {
        subSubList.value = searchData.data as dynamic;
        print(subSubList);
      } else {
        isSubLoading(false);
        update();
      }
    } catch (e) {
      isSubLoading(false);
      update();
      print(e.toString());
    } finally {
      isSubLoading(false);
      update();
    }

    update();
  }



}