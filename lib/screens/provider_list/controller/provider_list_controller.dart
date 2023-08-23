import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';

class ProviderListController extends GetxController {

  var isLoading = false.obs;
  var isProviderLoading = false.obs;
  var providerList = [].obs;
  var status = "".obs;
  var valueId = "true".obs;
  updateValue(val){
    valueId.value = val;
    update();

  }
  updateStatus(val){
    status.value = val;
    update();
  }
  var serviceViewList = [].obs;

  var subId = 0.obs;

  updateSubId(val){
subId.value = val;
update();
  }

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'All Services'),
    const Tab(text: 'Service Two'),
    const Tab(text: 'Service Three'),
    const Tab(text: 'Service Four'),
  ];



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    servicesList();


  }

  providerData({subCatId}) async{


    try{
      isProviderLoading(true);
      update();

      var providerViewData =await ApiManger.providerListResponse(id:subCatId );
      if(providerViewData!=null){
        providerList.value = providerViewData.data;
        update();
        print("testtstss");


        print(providerViewData.data.length);



      }
      else{
        isProviderLoading(false);
        update();
      }
    }
    catch(e){print(e.toString());}
    finally{
      isProviderLoading(false);
      update();
    }


    update();


  }



  //Services

  servicesList() async{


    try{
      isLoading(true);

      var serviceViewData =await ApiManger.serviceListResponse();
      if(serviceViewData!=null){
        serviceViewList.value = serviceViewData.data;
        update();
        print("testtstss");


        print(serviceViewData.data.length);



      }
      else{

      }
    }
    catch(e){print(e.toString());}
    finally{
      isLoading(false);
    }




  }







}