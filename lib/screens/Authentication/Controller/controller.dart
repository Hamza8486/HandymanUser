// ignore_for_file: avoid_print



import 'package:get/get.dart';
import 'package:user_apps/Services/api_manager.dart';



class AuthController extends GetxController {




  var cityList = [].obs;

  @override
  void onInit() {

    cityData();


    super.onInit();



  }




  cityData() async{


    try{

      update();

      var cityViewData =await ApiManger.cityResponse();
      if(cityViewData!=null){
        cityList.value = cityViewData.data;
        update();
        print("testtstss");


        print(cityViewData.data.length);



      }
      else{

        update();
      }
    }
    catch(e){print(e.toString());}
    finally{

      update();
    }
    update();


  }


}