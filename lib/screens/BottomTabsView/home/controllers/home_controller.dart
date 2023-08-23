// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/popular.dart';
import 'package:user_apps/screens/BottomTabsView/home/Model/service_model.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/chats_model.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/notification.dart';
import 'package:user_apps/screens/BottomTabsView/my_requests/Model/provider_detail.dart';
import 'package:user_apps/screens/BottomTabsView/profile/Model/get_profile_model.dart';
import 'package:user_apps/screens/favorite/Model/faourite_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var isNotiLoading = false.obs;
  var isproviderLoading = false.obs;
  var selectValue = "".obs;
  ScrollController scrollController = ScrollController();
  void scrollToLastMessage() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
  var read="".obs;
  updateRead(val){
    read.value=val;
    update();

  }
  updateSelectValue(val){
    selectValue.value = val;
    update();

  }
  var isFavLoading = false.obs;
  var isProfileLoading = false.obs;

  var allFavList = <FavModel>[].obs;
  var allPopList = <PopularData>[].obs;
  var isReqLoading = false.obs;
  var isPopLoading = false.obs;
  var allRequestList = [].obs;

  var activeRequestList = [].obs;
  var inActiveRequestList = [].obs;
  var compRequestList = [].obs;
  ProfileModel? profileMOdel;
  ProviderModelData? providerModelData;

  var catLoading = false.obs;
  var scrollLoading = true.obs;
  updateScrollLoading(val){
    scrollLoading.value=val;
    update();
  }
  var cityLoading = false.obs;
  var catList = [].obs;
  var bannerList = [].obs;
  var searchList = [].obs;
  var cityList = [].obs;
  var subId = "".obs;
  var providerId = "".obs;
  var userId = "".obs;
  var userIds = "".obs;
  var jobIds = "".obs;
  var address = "".obs;
  updateAddress(val) {
    address.value = val;
    update();
  }
  updateUserIds(val) {
    userIds.value = val;
    update();
  }
  updateJobIds(val) {
    jobIds.value = val;
    update();
  }
  updateProvider(val) {
    providerId.value = val;
    update();
  }

  @override
  Future<void> onInit() async {
    homeData();
    homeData1();
    allPopularData();
    // serviceJobData(id: "",sub: "");

    cityData();
    HelperFunctions.getFromPreference("id").then((value)  {
      userId.value = value;
        profileData(userId.value);
      allRequestData(userId.value);
      notData();

        allFavData(userId.value);
      update();
    });
    HelperFunctions.getFromPreference("userAddress").then((value) {
      address.value = value;
      update();
    });
    super.onInit();



  }

  updateSubId(val) {
    subId.value = val;
    update();
  }

  File? file;
  File? file1;

  double lat = 0.0;
  double lng = 0.0;
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  clearController() {
    addressController.clear();
    descriptionController.clear();
    locController.clear();
    budgetController.clear();
    file = null;
  }

  searchUpdate(var searchKeyword) async {
    try {
      isLoading(true);

      var searchData =
          await ApiManger.searchCategoryRes(category: searchKeyword);
      if (searchData != null) {
        searchList.value = searchData.data;
        print(searchList);
      } else {}
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }

  homeData() async {
    try {
      isLoading(true);
      update();

      var homeViewData = await ApiManger.homeResponse();
      if (homeViewData != null) {
        bannerList.value = homeViewData.data.banner;
        update();
        print("testtstss");

        print(homeViewData.data.banner.length);
      } else {
        isLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
      update();
    }

    update();
  }

  homeData1() async {
    try {
      catLoading(true);
      update();

      var homeViewData = await ApiManger.homeResponse();
      if (homeViewData != null) {
        catList.value = homeViewData.data.category;
        update();
        print("testtstss");

        print(homeViewData.data.category.length);
        print(homeViewData.data.banner.length);
      } else {
        catLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      catLoading(false);
      update();
    }

    update();
  }

  cityData() async {
    try {
      cityLoading(true);
      update();

      var cityViewData = await ApiManger.cityResponse();
      if (cityViewData != null) {
        cityList.value = cityViewData.data;
        update();
        print("testtstss");

        print(cityViewData.data.length);
      } else {
        cityLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      cityLoading(false);
      update();
    }
    update();
  }

  allRequestData(userIds) async {
    try {
      isReqLoading(true);
      update();

      var requestViewData = await ApiManger.allRequestResponse(id: userIds);
      if (requestViewData != null) {
        allRequestList.value = requestViewData.data?.all as dynamic;
        activeRequestList.value = requestViewData.data?.active as dynamic;
        inActiveRequestList.value = requestViewData.data?.inactive as dynamic;
        compRequestList.value = requestViewData.data?.completed as dynamic;
        update();
        print("testtstss");

        print(requestViewData.data?.all?.length);
      } else {
        isReqLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isReqLoading(false);
      update();
    }

    update();
  }

  allProviderData(userIds) async {
    try {
      isproviderLoading(true);
      update();

      var requestViewData = await ApiManger.providerDetail(id: userIds);
      if (requestViewData != null) {
        providerModelData = requestViewData.data;
        print(requestViewData.data);

        update();
        print("testtstss");
      } else {
        isproviderLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isproviderLoading(false);
      update();
    }

    update();
  }

  allFavData(userIds) async {
    try {
      isFavLoading(true);
      update();

      var requestViewData = await ApiManger.allFavResponse(id: userIds);
      if (requestViewData != null) {
        allFavList.value = requestViewData.data;
        update();
        print("testtstss");

        print(requestViewData.data.length);
      } else {
        isFavLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isFavLoading(false);
      update();
    }
    update();
  }

  allPopularData() async {
    try {
      isPopLoading(true);
      update();

      var requestViewData = await ApiManger.popularRes();
      if (requestViewData != null) {
        allPopList.value = requestViewData.data as dynamic;
        update();
        print("this is popular ${requestViewData.data}");

        print(requestViewData.data?.length);
      } else {
        isPopLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isPopLoading(false);
      update();
    }

    update();
  }

  profileData(var userIds) async {
    try {
      isProfileLoading(true);
      update();

      var provData = await ApiManger.profileResponse(id: userIds);
      if (provData != null) {
        profileMOdel = provData.data;
        update();

        print("THis is profile data Hmaza${provData.data}");
      } else {
        isProfileLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isProfileLoading(false);
      update();
    }

    update();
  }
  var valueAll = "All".obs;
  updateValueAll(val){
    valueAll.value = val;
    update();

  }
  var servicesList = <ServiceDataAll>[].obs;
  var isServiceBusinessAll = false.obs;
  serviceJobData({id,sub=""}) async{


    try{
      isServiceBusinessAll(true);
      update();

      var jobViewData =await ApiManger.servicesResponse(id:id,sub: sub);
      if(jobViewData!=null){
        servicesList.value = jobViewData.data as dynamic;
        update();
        print("testtstss");


        print(jobViewData.data?.length);




      }
      else{
        isServiceBusinessAll(false);
        update();
      }
    }
    catch(e){print(e.toString());}
    finally{
      isServiceBusinessAll(false);
      update();

    }

    update();


  }
  var isChatLoading = false.obs;

  updateChatLoading(val){
    isChatLoading.value=val;
    update();

  }
  var chatList = <ChatsAllModels>[].obs;
  chatData() async {
    try {


      var profileViewData = await ApiManger.getChatListaLL();
      if (profileViewData != null) {
        chatList.value = profileViewData.data?.chats as dynamic;
        scrollToLastMessage();
        update();

        print(profileViewData.data?.chats);
      } else {

      }
    } catch (e) {
      print(e.toString());
    } finally {

    }
    update();
  }
  var readData = "0".obs;
  updateReadData(val){
    readData.value=val;
    update();
  }
  var notificationList = <DataNotification>[].obs;
  notData() async {
    try {
      isNotiLoading(true);
      update();

      var profileViewData = await ApiManger.getNotificationAll();
      if (profileViewData != null) {
        notificationList.value = profileViewData.data as dynamic;
        profileViewData.data!.where((element) => element.isRead==null).isNotEmpty?
        updateReadData("0"):updateReadData("1");
        update();
        print("testtstss");

        print("This is notification");
        print(profileViewData.data);
      } else {
        isNotiLoading(false);
        update();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isNotiLoading(false);
      update();
    }
    update();
  }
}
